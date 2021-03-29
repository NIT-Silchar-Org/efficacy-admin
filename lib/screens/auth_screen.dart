import 'package:flutter/material.dart';

import '../widgets/auth_screen files/authCard.dart';
import '../widgets/signup_files/efficacyLogo.dart';

//added signup buttons

class AuthScreen extends StatelessWidget {
  static const routeName = '/choice-screen';

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            //defining background of signup screen
            Container(
              height: deviceSize.height,
              width: deviceSize.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [
                    Color.fromRGBO(53, 114, 164, 1),
                    Color.fromRGBO(37, 57, 118, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  stops: const [0, 1],
                ),
              ),
            ),
            //background will contain the logo
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: EfficacyLogo(
                    deviceSize: deviceSize,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: deviceSize.height * 0.05,
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: AuthCard(
                    deviceSize: deviceSize,
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
