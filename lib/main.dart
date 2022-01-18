import 'package:efficacy_admin/Pages/about_us.dart';
import 'package:efficacy_admin/Pages/account_screen.dart';
import 'package:efficacy_admin/Pages/club_details.dart';
import 'package:efficacy_admin/Pages/edit_account_screen.dart';
import 'package:efficacy_admin/Pages/home_page.dart';
import 'package:efficacy_admin/Pages/sign_up.dart';
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
      home: const Googlelogin(),
      routes: {
        Googlelogin.id : (context) => const Googlelogin(),
        SignupPage.id : (context) => const SignupPage(),
        HomePage.id : (context) => const HomePage(),
        EventDetail.id: (context) => const EventDetail(),
        AboutUsPage.id: (context) => const AboutUsPage(),
        EditAccount.id: (context)  => EditAccount(),
        Account.id : (context) => Account(),
        ClubDetailsPage.id : (context) => const ClubDetailsPage(),


      },
    );
  }
}
