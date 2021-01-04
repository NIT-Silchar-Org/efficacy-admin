import 'package:cmApp/providers/dropDownItem_provider.dart';
import 'package:provider/provider.dart';

import 'package:cmApp/screens/login_screen.dart';
import 'package:cmApp/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import './authButton.dart';

class AuthCard extends StatelessWidget {
  Size deviceSize;
  AuthCard({
    @required this.deviceSize,
  });

  @override
  Widget build(BuildContext context) {
    return
        // Card(
        //   shadowColor: Color.fromRGBO(37, 57, 118, 1),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(25.0),
        //   ),
        //   elevation: 8.0,
        //   child:
        Container(
      height: deviceSize.height * 0.58,
      width: deviceSize.width * 0.85,
      padding: const EdgeInsets.all(16),
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: deviceSize.height*0.17,),
          InkWell(
            borderRadius: BorderRadius.circular(205),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            child: AuthButton(buttonName: 'Login'),
          ),

          SizedBox(height: deviceSize.height*0.05,),
          InkWell(
            borderRadius: BorderRadius.circular(205),
            onTap: () {
              Provider.of<DropdownItems>(context, listen: false).loadClubs();
              Navigator.of(context)
                  .pushReplacementNamed(SignupScreen.routeName);
            },
            child: AuthButton(buttonName: 'SignUp'),
          )
        ],
      ),
    );
    // );
  }
}
