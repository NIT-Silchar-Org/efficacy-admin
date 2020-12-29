import 'package:cmApp/firebase/admin_firebase.dart';
import 'package:cmApp/models/http_exception.dart';
import 'package:cmApp/providers/authentication_provider.dart';
import 'package:cmApp/screens/club_activity_screen.dart';
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
      // print(_adminCredentials['email']);
      // print(_adminCredentials['password']);
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
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
              });
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  void _next() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    print(passwordController.text);
    print(_adminCredentials['email']);
    setState(() {
      _isNextClicked = true;
    });

    // _formKey.currentState.save();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _adminCredentials = {
    'name': null,
    'email': null,
    'password': null,
    'club': null,
    'branch': null,
  };
  bool _isLoading = false;
  bool _isNextClicked = false;
  bool _isDropdownValid = false;

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
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
                child: !_isNextClicked
                    ? SignupPart1(
                        adminCredentials: _adminCredentials,
                        passwordController: passwordController,
                        emailController: emailController,
                        next: _next,
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
                      _next();
                    },
                    child: SignupCardButton(buttonName: 'Next'),
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
                                  _submit().then<void>((_) {
                                    userSetup(_adminCredentials);
                                  }).then((_) {
                                    _authdata.isAuthenticated
                                        ? Navigator.of(context)
                                            .pushReplacementNamed(
                                                ClubActivityScreen.routeName)
                                        : null;
                                  });

                                  // print(_adminCredentials['password']);
                                },
                                child: SignupCardButton(buttonName: 'Sign Up'),
                              ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
