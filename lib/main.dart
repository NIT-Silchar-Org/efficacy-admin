import 'package:efficacy_admin/themes/app_theme.dart';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
  int _value = 1;
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
              decoration: const BoxDecoration(
                color: Color(0xFFC4C4C4),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(59, 0, 59, 0),
              child: Column(
                children: [
                  TextFormField(
                    readOnly: true,
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
                          color: AppColorDark.outline,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColorLight.outline,
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
                            color: AppColorDark.onPrimary, width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColorLight.outline,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 27),
                  IntlPhoneField(
                    initialCountryCode: '+91',
                    showCountryFlag: false,
                    decoration: InputDecoration(
                      isDense:
                          true, // this will remove the default content padding
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 5,
                      ),
                      hintText: 'Phone number',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        color: AppColorLight.outline,
                        fontWeight: FontWeight.w500,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColorDark.onPrimary,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColorLight.outline,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  builddropdown(),
                ],
              ),
            ),
            const SizedBox(height: 55),
            Container(
              margin: const EdgeInsets.fromLTRB(48, 0, 48, 0),
              child: SizedBox(
                height: 44,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColorDark.onPrimary),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFFFFFF),
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget builddropdown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        isDense: true, // this will remove the default content padding
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 5,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColorDark.onPrimary,
            width: 2.0,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColorLight.outline,
            width: 2.0,
          ),
        ),
      ),
      value: _value,
      items: [
        DropdownMenuItem(
          child: Text(
            "GDSC",
            style: TextStyle(
              fontSize: 20.0,
              color: AppColorLight.outline,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: 1,
        ),
        DropdownMenuItem(
          child: Text(
            "ECO CLUBS",
            style: TextStyle(
              fontSize: 20.0,
              color: AppColorLight.outline,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: 2,
        )
      ],
      onChanged: (value) {
        setState(() {
          _value = value as int;
        });
      },
    );
  }
}
