import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './providers/authentication_provider.dart';
import './providers/clubDetails_provider.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        // ChangeNotifierProxyProvider<AuthenticationProvider,
        //     ClubDetailsProvider>(
        //   create: (BuildContext context) => ClubDetailsProvider(uid: ''),
        //   update: (context, auth, clubDetails) => ClubDetailsProvider(
        //     uid: auth.userId,
        //   ),
       // ),
        ChangeNotifierProxyProvider<AuthenticationProvider, AdminProvider>(
          create: (BuildContext context) => AdminProvider(null),
          update: (context, auth, adminProvider) => AdminProvider(
            auth.userId,
          ),
        ),
        ChangeNotifierProxyProvider<AdminProvider, EventProvider>(
          create: (BuildContext context) => EventProvider(''),
          update: (context, clubDetails, events) => EventProvider(
            clubDetails.clubId,
          ),
        ),
        ChangeNotifierProvider<DropdownItems>(
          create: (BuildContext ctx) => DropdownItems(),
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
                  button: const TextStyle(
                    color: Color.fromRGBO(37, 57, 118, 1),
                  ),
                ),
            buttonColor: const Color.fromRGBO(37, 57, 118, 1),
          ),
          home: auth.isAuthenticated
              ? ClubActivityScreen()
              : FutureBuilder<bool>(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      (authResultSnapshot.connectionState ==
                              ConnectionState.waiting)
                          ? LoadingSplashScreen()
                          : (authResultSnapshot.data == false
                              ? AuthScreen()
                              : ClubActivityScreen()),
                ), //AuthScreen(),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            SignupScreen.routeName: (ctx) => SignupScreen(),
            ClubActivityScreen.routeName: (ctx) => ClubActivityScreen(),
            AddEventScreen.routeName: (ctx) => AddEventScreen(),
            EventDetailsScreen.routeName: (ctx) => EventDetailsScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            //SettingsScreen.routeName:(ctx)=>SettingsScreen(),
          },
        ),
      ),
    );
  }
}
