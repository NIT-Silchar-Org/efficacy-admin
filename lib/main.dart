import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/dropDownItem_provider.dart';
import './providers/signup_provider.dart';
import './screens/signup_screen.dart';

void main() {
  runApp(CMapp());
}

class CMapp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DropdownItems>(
          create: (BuildContext ctx) => DropdownItems(),
        ),
        ChangeNotifierProvider<SignupProvider>(
          create: (BuildContext ctx) => SignupProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Efficacy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(37, 57, 118, 1),
                ),
                subtitle1: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(37, 57, 118, 1),
                ),
                button: const TextStyle(
                  color: Color.fromRGBO(37, 57, 118, 1),
                ),
              ),
          buttonColor: const Color.fromRGBO(37, 57, 118, 1),
        ),
        home: SignupPage(),
      ),
    );
  }
}
