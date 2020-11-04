import 'package:cmApp/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './nextButton.dart';
import './signupButton.dart';
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
    await Provider.of<SignupProvider>(context, listen: false)
        .signUp(_adminCredentials['email'], _adminCredentials['password']);
    setState(() {
      _isLoading = false;
    });
  }

  void _next() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    setState(() {
      _isNextClicked = true;
    });

    _formKey.currentState.save();
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
                    onTap: () {
                      _next();
                    },
                    child: NextButton(),
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
                        child: InkWell(
                          onTap: () {
                            //print(_adminCredentials['club']);
                            _submit();
                            // print(_adminCredentials['password']);
                          },
                          child: SignupButton(isLoading: _isLoading,),
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
