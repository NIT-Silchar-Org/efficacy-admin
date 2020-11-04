import 'package:flutter/material.dart';

///**************************First part of signup page***********************///

class SignupPart1 extends StatefulWidget {
  const SignupPart1({
    Key key,
    @required Map<String, String> adminCredentials,
    @required TextEditingController passwordController,
    @required TextEditingController emailController,
    @required this.next,
  })  : _adminCredentials = adminCredentials,
        _passwordController = passwordController,
        _emailController = emailController,
        super(key: key);

  final Map<String, String> _adminCredentials;
  final TextEditingController _passwordController;
  final TextEditingController _emailController;
  final Function next;

  @override
  _SignupPart1State createState() => _SignupPart1State();
}

class _SignupPart1State extends State<SignupPart1> {
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();


//do dispose our focus nodes
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

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
                !value.endsWith('.com')||
                !value.contains('gmail.com')) {
              return 'Invalid Email';
            }
            return null;
          },
          style: Theme.of(context).textTheme.headline6,
          controller: widget._emailController,
          onSaved: (String value) => widget._adminCredentials['email'] = value,
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
          controller: widget._passwordController,
          onSaved: (value) => widget._adminCredentials['password'] = value,
          focusNode: _passwordFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            Focus.of(context).requestFocus(_confirmPasswordFocusNode);
          },
        ),
        /************* Confirm Password ************/
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: Theme.of(context).textTheme.subtitle1,
          ),
          validator: (value) {
            if (value != widget._passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontFamily: 'Roboto',
              ),
          obscureText: true,
          obscuringCharacter: '*',
          focusNode: _confirmPasswordFocusNode,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) {
            widget.next();
          },
        ),
        SizedBox(
          height: 35,
        ),
      ],
    );
  }
}
