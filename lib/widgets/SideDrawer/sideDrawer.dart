import 'package:cmApp/providers/authentication_provider.dart';
import 'package:cmApp/screens/addEvent_screen.dart';
import 'package:cmApp/screens/auth_screen.dart';
import 'package:cmApp/screens/profile_screen.dart';

//import 'package:cmApp/screens/settings_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './customDrawerHeader.dart';
import './drawerItem.dart';

class SideDrawer extends StatelessWidget {
  Size deviceSize;
  SideDrawer(this.deviceSize);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize.width * 0.9,
      child: Drawer(
        child: ListView(
          children: [
            CustomDrawerHeader(), //Drawer Head

            //--Drawer Items--

            DrawerItem(
              icon: Icons.home,
              itemName: 'Home',
            ), //Home

            DrawerItem(
              icon: Icons.add,
              itemName: 'Add Event',
              routeName: AddEventScreen.routeName,
            ),

            //Add Event

            DrawerItem(
              icon: Icons.person_rounded,
              itemName: 'Account',
              routeName: ProfileScreen.routeName,
            ), //Settings

//-----------------------Logout-----------------------//
            ListTile(
              leading: Icon(
                Icons.power_settings_new_rounded,
                size: 25,
              ),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
                Provider.of<AuthenticationProvider>(context, listen: false)
                    .logout();
                Navigator.of(context)
                    .pushReplacementNamed(AuthScreen.routeName);
              },
            ),
            //----------------------/Logout--------------------//
          ],
        ),
      ),
    );
  }
}
