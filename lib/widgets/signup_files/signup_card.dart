import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmApp/providers/authentication_provider.dart';
import 'package:cmApp/providers/dropDownItem_provider.dart';
import 'package:cmApp/screens/club_activity_screen.dart';
import 'package:cmApp/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import './signupCard_Button.dart';
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
  Future<void> _submit(String passcode) async {
    if ((!_formKey.currentState.validate()) ||
        (_adminCredentials['clubName'] == null) ||
        _adminCredentials['branch'] == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    } else if (passcode != null && passcodeController.text != passcode) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'INVALID PASSCODE: Please signup ONLY IF you are a club moderator!'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      passcode = passcode == null ? '123456' : passcode;
      await Provider.of<AuthenticationProvider>(context, listen: false)
          .signUp(_adminCredentials['email'], password, _adminCredentials)
          .then((_) {
        FirebaseFirestore.instance
            .collection('clubs')
            .doc(_adminCredentials['clubId'])
            .update({'passcode': passcode});
      });
      print(_adminCredentials['adminName']);
      print(_adminCredentials['email'] + '1');
      print(_adminCredentials['branch'] + '1');
    } catch (error) {
      print(error);
      var errorMessage = 'An Error has occured! Please check your credentials';
      if (error.message != null) {
        if (error.code == 'email-already-in-use')
          errorMessage = "Email already exists";
        else if (error.code == 'network-request-failed')
          errorMessage = "Network Error! Please check your internet connection";
        else if (error.code == 'invalid-email')
          errorMessage = "INVALID EMAIL: Please enter a valid email adress";
        else if (error.code == 'too-many-requests')
          errorMessage =
              "We have blocked all requests from this device due to unusual activity. Try again later.";
        else
          errorMessage = "INTERNAL ERROR: Something went wrong!";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> _passcodeCheckerDialogue(
      String passcode, BuildContext context) async {
    await Alert(
        context: context,
        title: "Enter Passcode",
        desc: 'Ask an existing admin for the passcode',
        content: Column(
          children: <Widget>[
            TextField(
              obscureText: true,
              controller: passcodeController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                FocusManager.instance.primaryFocus.unfocus();
                Navigator.of(context).pop();
                _submit(passcode).then((_) {
                  FocusManager.instance.primaryFocus.unfocus();
                  (FirebaseAuth.instance.currentUser.uid != null)
                      ? Navigator.of(context)
                          .pushReplacementNamed(ClubActivityScreen.routeName)
                      : null;
                });
              },
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Passcode',
                labelStyle: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: Theme.of(context).textTheme.button,
            ),
          ),
          DialogButton(
            onPressed: () async {
              Navigator.pop(context);
              _submit(passcode).then((_) {
                FocusManager.instance.primaryFocus.unfocus();
                (FirebaseAuth.instance.currentUser.uid != null)
                    ? Navigator.of(context)
                        .pushReplacementNamed(ClubActivityScreen.routeName)
                    : null;
              });
            },
            child: Text(
              "OK",
              style: Theme.of(context).textTheme.button,
            ),
          )
        ]).show();
  }

  Future<void> _next(String email, String pass, BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    print(passwordController.text);
    print(_adminCredentials['email']);

    _adminCredentials['email'] = email.trim();
    password = pass.trim();
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
    'adminName': null,
    'email': null,
    'clubName': null,
    'branch': null,
    // 'uid': null,
    'clubId': null,
    'fb': null,
    'linkedin': null,
  };
  bool _isLoading = false;
  bool _isNextClicked = false;
  bool _isNextLoading = false;
  bool buttonValue = false;

  String password;
  String passcode;

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passcodeController = TextEditingController();

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
                child: (!_isNextClicked || _isNextLoading)
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
                            onSaved: (value) => password = value,
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
                              password = passwordController.text;
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
                                    onTap: () async {
                                      await FirebaseFirestore.instance
                                          .collection('clubs')
                                          .doc(_adminCredentials['clubId']
                                              .toString())
                                          .get()
                                          .then((clubSnapshot) {
                                        passcode =
                                            clubSnapshot.data()['passcode'];
                                      }).then((_) {
                                        if (passcode != null)
                                          _passcodeCheckerDialogue(
                                              passcode, context);
                                        else {
                                          _submit(passcode).then((_) {
                                            FocusManager.instance.primaryFocus
                                                .unfocus();
                                            (FirebaseAuth.instance.currentUser
                                                        .uid !=
                                                    null)
                                                ? Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        ClubActivityScreen
                                                            .routeName)
                                                : null;
                                          });
                                        }
                                      });
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
