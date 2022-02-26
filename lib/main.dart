import 'package:efficacy_admin/Pages/about_us.dart';
import 'package:efficacy_admin/Pages/account_screen.dart';
import 'package:efficacy_admin/Pages/club_details.dart';
import 'package:efficacy_admin/Pages/event_detail.dart';
import 'package:efficacy_admin/Pages/edit_account_screen.dart';
import 'package:efficacy_admin/Pages/home_page.dart';
import 'package:efficacy_admin/Pages/sign_up.dart';
import 'package:efficacy_admin/services/user_authentication.dart';
import 'package:efficacy_admin/themes/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'Pages/continue_with_google.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GoogleSignInProvider>(
          create: (context) => GoogleSignInProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<GoogleSignInProvider>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Efficacy Admin',
        theme: AppTheme.light,
        home: const AuthenticationWrapper(),
        routes: {
          Googlelogin.id: (context) => const Googlelogin(),
          SignupPage.id: (context) => const SignupPage(),
          HomePage.id: (context) => const HomePage(),
          EventDetail.id: (context) => const EventDetail(),
          AboutUsPage.id: (context) => const AboutUsPage(),
          EditAccount.id: (context) => EditAccount(),
          Account.id: (context) => Account(),
          ClubDetailsPage.id: (context) => const ClubDetailsPage(),
        },
        // onGenerateRoute: (settings) {
        //   switch (settings.name) {
        //     case SignupPage.id:
        //       {
        //         return PageTransition(
        //           child: const SignupPage(),
        //           childCurrent: const Googlelogin(),
        //           type: PageTransitionType.rightToLeftJoined,
        //           duration: const Duration(milliseconds: 300),
        //           reverseDuration: const Duration(milliseconds: 300),
        //         );
        //       }
        //     case HomePage.id:
        //       {
        //         return PageTransition(
        //           child: const HomePage(),
        //           type: PageTransitionType.rightToLeftWithFade,
        //           duration: const Duration(milliseconds: 300),
        //           reverseDuration: const Duration(milliseconds: 300),
        //         );
        //       }
        //     default:
        //       return null;
        //   }
        // },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final googleUser = Provider.of<GoogleSignInProvider>(context).user;
    return const HomePage();
    // if (firebaseUser != null) {
    //   return const HomePage();
    // }
    // if (googleUser != null) {
    //   return const SignupPage();
    // }
    // return const Googlelogin();
  }
}
