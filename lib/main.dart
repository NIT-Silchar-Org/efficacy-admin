import 'package:efficacy_admin/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'Pages/continue_with_google.dart';
import '/Pages/add_edit_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Efficacy Admin',
      theme: AppTheme.light,
      home: const AddEvent(),
    );
  }
}
