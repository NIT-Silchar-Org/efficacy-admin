import 'package:flutter/material.dart';

class SignupCard extends StatefulWidget {
  Size deviceSize;

  SignupCard({
    @required this.deviceSize,
  });

  @override
  _SignupCardState createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _adminCredentials = {
    'email': '',
    'password': '',
    'club': '',
  };
  bool _isLoading = false;
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
                      child: Column(
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
                        !value.endsWith('gmail.com')) {
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
                  style: Theme.of(context).textTheme.headline6,
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
                    return'';
                  },
                  style: Theme.of(context).textTheme.headline6,
                  obscureText: true,
                  obscuringCharacter: '*',
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
