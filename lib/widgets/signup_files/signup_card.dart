// import 'dart:ffi';

// import 'package:cmApp/providers/admin_firebase_provider.dart';
import 'package:cmApp/models/http_exception.dart';
import 'package:cmApp/providers/authentication_provider.dart';
import 'package:cmApp/providers/clubDetails_provider.dart';
import 'package:cmApp/providers/dropDownItem_provider.dart';
import 'package:cmApp/screens/club_activity_screen.dart';
import 'package:cmApp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './signupCard_Button.dart';
import './signup_part_1.dart';
import './signup_part_2.dart';

class SignupCard extends StatefulWidget {
  Size deviceSize;

  SignupCard({
    @required this.deviceSize,
  });

  @override
  _SignupCardState createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  Future<void> _submit() async {
    if ((!_formKey.currentState.validate()) ||
        (_adminCredentials['club'] == null) ||
        _adminCredentials['branch'] == null) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthenticationProvider>(context, listen: false)
          .signUp(_adminCredentials['email'], _adminCredentials['password']);
      print(_adminCredentials['name']);
      print(_adminCredentials['email'] + '1');
      print(_adminCredentials['branch'] + '1');
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
      _hasError = true;
      var errorMessage = 'Authentication Failed!';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'The email has already been registered';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        //when pass is<6 words, this error is thrown , by fire base
        errorMessage = 'This password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'The email or password you entered was incorrect';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'The email or password you entered was incorrect';
      }
      print(error);
      _showErrorDialogue(errorMessage);
    } catch (error) {
      _hasError = true;
      const errorMessage = 'Oops! Something went wrong.';
      print(error);
      _showErrorDialogue(errorMessage);
    }
  }

  void _showErrorDialogue(String message) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An error has occured'),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _isLoading = false;
                _hasError = false;
              });
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  Future<void> _next(
      String email, String password, BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    print(passwordController.text);
    print(_adminCredentials['email']);

    _adminCredentials['email'] = email;
    _adminCredentials['password'] = password;
    setState(() {
      _isNextLoading = true;
      _isNextClicked = true;
    });

    await Provider.of<DropdownItems>(context, listen: false)
        .loadClubs()
        .then((_) {
      setState(() {
        _isNextLoading = false;
        print('club loaded');
      });
    });

    // _formKey.currentState.save();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _adminCredentials = {
    'name': null,
    'email': null,
    'club': null,
    'branch': null,
    'uid': null,
    'clubId': null,
    'fb': null,
    'linkedin': null,
  };
  bool _isLoading = false;
  bool _isNextClicked = false;
  bool _isNextLoading = false;
  bool _hasError = false;

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

//do dispose our focus nodes
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var _authdata = Provider.of<AuthenticationProvider>(context);
    // final dropdownItem = Provider.of<DropdownItems>(context, listen: false);
    return Card(
      shadowColor: Color.fromRGBO(37, 57, 118, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      elevation: 8.0,
      child: Container(
        height: widget.deviceSize.height * 0.58,
        width: widget.deviceSize.width * 0.85,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: (!_isNextClicked||_isNextLoading)
                    //-------------------if next clicked , code for part 1----------------------
                    ? Column(
                        children: <Widget>[
/***************Email Field*******************/
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email Id',
                              labelStyle: Theme.of(context).textTheme.subtitle1,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty ||
                                  !value.contains('@') ||
                                  !value.contains('.')) {
                                return 'Invalid Email';
                              }
                              return null;
                            },
                            style: Theme.of(context).textTheme.headline6,
                            controller: emailController,
                            onSaved: (String value) =>
                                _adminCredentials['email'] = value,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              Focus.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                          ),
/****************Password Field*****************/
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: Theme.of(context).textTheme.subtitle1,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field can\'t be empty';
                              }
                              if (value.length < 6) {
                                return 'Password should be atleast 6 characters long';
                              }
                              return null;
                            },
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      fontFamily: 'Roboto',
                                    ),
                            obscureText: true,
                            obscuringCharacter: '*',
                            controller: passwordController,
                            onSaved: (value) =>
                                _adminCredentials['password'] = value,
                            focusNode: _passwordFocusNode,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              Focus.of(context)
                                  .requestFocus(_confirmPasswordFocusNode);
                            },
                          ),
                          /************* Confirm Password ************/
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: Theme.of(context).textTheme.subtitle1,
                            ),
                            validator: (value) {
                              if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      fontFamily: 'Roboto',
                                    ),
                            obscureText: true,
                            obscuringCharacter: '*',
                            focusNode: _confirmPasswordFocusNode,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) {
                              // print(widget._adminCredentials['email']);
                              _adminCredentials['email'] = emailController.text;
                              _adminCredentials['password'] =
                                  passwordController.text;
                              print(_adminCredentials['email'] +
                                  passwordController.text +
                                  'this is email id');
                              _next(emailController.text,
                                  passwordController.text, context);
                              //print(widget._adminCredentials['email']+'2');
                            },
                          ),
                          SizedBox(
                            height: 35,
                          ),
                        ],
                      )
                    : SignupPart2(
                        adminCredentials: _adminCredentials,
                        deviceSize: widget.deviceSize,
                        nameController: nameController,
                      ),
              ),
            ),
            !_isNextClicked
                ? InkWell(
                    borderRadius: BorderRadius.circular(205),
                    onTap: () {
                      _next(emailController.text, passwordController.text,
                          context);
                    },
                    child: SignupCardButton(buttonName: 'Next'),
                  )
                : (_isNextLoading)
                    ? Center(
                        widthFactor: 4.5,
                        child: CircularProgressIndicator(),
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            padding: EdgeInsets.all(4.0),
                            alignment: Alignment.centerLeft,
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 45,
                              color: Theme.of(context).buttonColor,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  _isNextClicked = false;
                                },
                              );
                            },
                          ),
                          SizedBox(width: widget.deviceSize.width * 0.08),
                          Container(
                            alignment: Alignment.center,
                            child: _isLoading
                                ? Center(
                                    widthFactor: 4.5,
                                    child: CircularProgressIndicator())
                                : InkWell(
                                    borderRadius: BorderRadius.circular(205),
                                    onTap: () {
                                      //print(_adminCredentials['club']);
                                      _submit().then((_) {
                                        _adminCredentials['uid'] =
                                            Provider.of<AuthenticationProvider>(
                                                    context,
                                                    listen: false)
                                                .userId;
                                      }).then<void>((_) {
                                        !_hasError
                                            ? Provider.of<
                                                        AuthenticationProvider>(
                                                    context,
                                                    listen: false)
                                                .userSetup(_adminCredentials)
                                            : null;
                                      }).then((_) {
                                        FocusManager.instance.primaryFocus
                                            .unfocus();
                                        _authdata.isAuthenticated
                                            ? Navigator.of(context)
                                                .pushReplacementNamed(
                                                    ClubActivityScreen
                                                        .routeName)
                                            : null;
                                      });

                                      // print(_adminCredentials['password']);
                                    },
                                    child:
                                        SignupCardButton(buttonName: 'Sign Up'),
                                  ),
                          ),
                        ],
                      ),
            SizedBox(
              height: 30,
            ),
            _isLoading
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: Text(
                      'Login Instead',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
