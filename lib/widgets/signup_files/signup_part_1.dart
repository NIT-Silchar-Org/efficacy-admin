import 'package:flutter/material.dart';


///**************************First part of signup page***********************///

class SignupPart1 extends StatelessWidget {
  const SignupPart1({
    Key key,
    @required Map<String, String> adminCredentials,
    @required TextEditingController passwordController,
  })  : _adminCredentials = adminCredentials,
        _passwordController = passwordController,
        super(key: key);

  final Map<String, String> _adminCredentials;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                !value.endsWith('@gmail.com') ||
                !value.endsWith('@yahoo.com')) {
              return 'Invalid Email';
            }
            return '';
          },
          style: Theme.of(context).textTheme.headline6,
          onSaved: (String value) => _adminCredentials['email'] = value,
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
            return '';
          },
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontFamily: 'Roboto',
              ),
          obscureText: true,
          obscuringCharacter: '*',
          onSaved: (value) => _adminCredentials['password'] = value,
        ),
        /************* Confirm Password ************/
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: Theme.of(context).textTheme.subtitle1,
          ),
          validator: (value) {
            if (value != _passwordController) {
              return 'Passwords do not match';
            }
            return '';
          },
          style: Theme.of(context).textTheme.headline6,
          obscureText: true,
          obscuringCharacter: '*',
        ),
        SizedBox(
          height: 35,
        ),
      ],
    );
  }
}