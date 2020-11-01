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
      ),
      home: SignupPage(),
    );
  }
}
