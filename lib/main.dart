import 'package:dsc_club_management_app/screens/add_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddEvent(),
      // routes: {'/signup.dart': (_) => signup(), '/homepage': (_) => homePage()},
    );
  }
}
