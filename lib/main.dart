import 'package:cmApp/providers/developerDetails_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './providers/authentication_provider.dart';
import './providers/adminDetails_provider.dart';
import './providers/dropDownItem_provider.dart';
import './providers/event_provider.dart';
import './screens/addEvent_screen.dart';
import './screens/auth_screen.dart';
import './screens/club_activity_screen.dart';
import './screens/eventDetails_screen.dart';
import './screens/loading_splash_screen.dart';
import './screens/login_screen.dart';
import './screens/profile_screen.dart';
import './screens/signup_screen.dart';
import 'screens/about_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  runApp(CMapp());
}

class CMapp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (BuildContext ctx) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider<AdminProvider>(
          create: (BuildContext context) => AdminProvider(),
        ),
        ChangeNotifierProxyProvider<AdminProvider, EventProvider>(
          create: (BuildContext context) => EventProvider('', ''),
          update: (context, clubDetails, events) => EventProvider(
            clubDetails.clubId,
            clubDetails.clubName,
          ),
        ),
        ChangeNotifierProvider<DropdownItems>(
          create: (BuildContext ctx) => DropdownItems(),
        ),
        ChangeNotifierProvider<DeveloperDetailProvider>(
          create: (BuildContext ctx) => DeveloperDetailProvider(),
        ),
      ],
      child: Consumer<AuthenticationProvider>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Efficacy',
          theme: ThemeData(
            primaryColor: Colors.blue[900],
            backgroundColor: Colors.blue[900],
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'CenturyGothic',
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(37, 57, 118, 1),
                  ),
                  subtitle1: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'CenturyGothic',
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(37, 57, 118, 1),
                  ),
                  bodyText1: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'CenturyGothic',
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(37, 57, 118, 1),
                  ),
                  button: const TextStyle(
                    color: Color.fromRGBO(37, 57, 118, 1),
                  ),
                ),
            buttonColor: const Color.fromRGBO(37, 57, 118, 1),
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, authResultSnapshot) =>
                (authResultSnapshot.connectionState == ConnectionState.waiting)
                    ? LoadingSplashScreen()
                    : authResultSnapshot.hasData
                        ? ClubActivityScreen()
                        : AuthScreen(),
          ), //AuthScreen(),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            SignupScreen.routeName: (ctx) => SignupScreen(),
            ClubActivityScreen.routeName: (ctx) => ClubActivityScreen(),
            AddEventScreen.routeName: (ctx) => AddEventScreen(),
            EventDetailsScreen.routeName: (ctx) => EventDetailsScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            AboutScreen.routeName: (ctx) => AboutScreen(),
            //SettingsScreen.routeName:(ctx)=>SettingsScreen(),
          },
        ),
      ),
    );
  }
}
