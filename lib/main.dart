import 'package:flutter/material.dart';

import './screens/signup_screen.dart';

void main() {
  runApp(CMapp());
}

class CMapp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Efficacy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: const TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
                color:  Color.fromRGBO(37, 57, 118, 1),
              ),
              subtitle1: const TextStyle(
                fontSize: 18,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.normal,
                color:  Color.fromRGBO(37, 57, 118, 1),
              ),
              button: const TextStyle(
                color: Color.fromRGBO(37, 57, 118, 1),
              ),
            ),
      ),
      home: SignupPage(),
    );
  }
}
