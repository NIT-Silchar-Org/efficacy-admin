import './screens/profile.dart';
import './screens/wrapper.dart';
import 'package:flutter/material.dart';

import './screens/clubs.dart';
import './screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      routes: {
        "/": (context) => Wrapper(),
        "/register": (context) => Register(),
        "/clubs": (context) => Clubs(),
        "/profile": (context) => Profile(),
      },
    );
  }
}
