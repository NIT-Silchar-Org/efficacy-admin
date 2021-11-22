import 'package:efficacy_admin/themes/app_theme.dart';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:flutter/material.dart';

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
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin:
                  const EdgeInsets.only(left: 0, top: 72, right: 0, bottom: 43),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: AppColorLight.outline,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(59, 0, 59, 0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      isDense:
                          true, // this will remove the default content padding
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 5,
                      ),
                      hintText: 'efficacy@gmail.com',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        color: AppColorLight.outline,
                        fontWeight: FontWeight.w500,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColorLight.outline, width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColorLight.primary,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 27),
                  TextFormField(
                    decoration: InputDecoration(
                      isDense:
                          true, // this will remove the default content padding
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 5,
                      ),
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        color: AppColorLight.outline,
                        fontWeight: FontWeight.w500,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColorLight.outline, width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColorLight.primary,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
