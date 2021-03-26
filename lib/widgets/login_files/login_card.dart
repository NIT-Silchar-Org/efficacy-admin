import 'package:cmApp/models/http_exception.dart';
import 'package:cmApp/providers/authentication_provider.dart';
import 'package:cmApp/providers/clubDetails_provider.dart';
import 'package:cmApp/screens/club_activity_screen.dart';
import 'package:cmApp/screens/signup_screen.dart';
//import 'package:cmApp/screens/club_activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './loginButton.dart';
// import './signup_part_1.dart';
// import './signup_part_2.dart';

class LoginCard extends StatefulWidget {
  Size deviceSize;

  LoginCard({
    @required this.deviceSize,
  });

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _isLoading = false;
//do dispose our focus nodes
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthenticationProvider>(context, listen: false)
          .login(_adminCredentials['email'], _adminCredentials['password']);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication Failed!';
      if (error.message != null) {
        errorMessage = error.message;
      }
      _showErrorDialogue(errorMessage);
    } catch (error) {
      const errorMessage = 'Oops! Something went wrong.';
      _showErrorDialogue(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _adminCredentials = {
    'email': null,
    'password': null,
  };

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
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  // final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final dropdownItem = Provider.of<DropdownItems>(context, listen: false);
    var _authdata = Provider.of<AuthenticationProvider>(context);
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
              child: Column(
                children: [
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
                          !value.endsWith('.com') ||
                          !value.contains('gmail.com')) {
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
                      Focus.of(context).requestFocus(_passwordFocusNode);
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
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontFamily: 'Roboto',
                        ),
                    obscureText: true,
                    obscuringCharacter: '*',
                    controller: passwordController,
                    onSaved: (value) => _adminCredentials['password'] = value,
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      _login().then((_) {
                        FocusManager.instance.primaryFocus.unfocus();
                        // _authdata.isAuthenticated
                        //     ? Navigator.of(context).pushReplacementNamed(
                        //         ClubActivityScreen.routeName)
                        //     : null;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 85,
            ),
            _isLoading
                ? const Center(
                    widthFactor: 4.5, child: CircularProgressIndicator())
                : InkWell(
                    borderRadius: BorderRadius.circular(205),
                    onTap: () {
                      _login().then<void>((value) {
                        FocusManager.instance.primaryFocus.unfocus();
                        //Navigator.of(context).pushReplacementNamed('/');
                      });
                    },
                    child: LoginButton(buttonName: 'Login'),
                  ),
            SizedBox(
              height: 30,
            ),
            _isLoading
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SignupScreen.routeName);
                    },
                    child: Text(
                      'SignUp Instead',
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
