import 'package:cmApp/providers/dropDownItem_provider.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _adminCredentials = {
    'name': '',
    'email': '',
    'password': '',
    'club': '',
    'branch': '',
  };
  bool _isLoading = false;
  bool _isNextClicked = false;
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dropdownItem = Provider.of<DropdownItems>(context, listen: false);
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
                        passwordController: _passwordController,
                      )
                    : SignupPart2(
                        adminCredentials: _adminCredentials,
                        deviceSize: widget.deviceSize,
                      ),
              ),
            ),
            !_isNextClicked
                ? InkWell(
                    onTap: () {
                      setState(() {
                        _isNextClicked = true;
                      });
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
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              print(_adminCredentials['club']);
                              print(_adminCredentials['branch']);
                            },
                            child: SignupButton(),
                          ),
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
