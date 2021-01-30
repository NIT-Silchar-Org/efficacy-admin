import 'package:cmApp/providers/adminDetails_provider.dart';
import 'package:cmApp/providers/authentication_provider.dart';
//import 'package:cmApp/providers/clubDetails_provider.dart';
import 'package:cmApp/utilities/loadingSpinner.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  Future<void> _loadAdminDetails(BuildContext ctx) async {
    await Provider.of<AuthenticationProvider>(ctx, listen: false)
        .getAdminDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder:(context, adminProvider, _)=> StreamBuilder(
          stream: adminProvider.getAdminProfile,
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[200],
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: LoadingSpinner(),
              );
            } else if (dataSnapshot.hasError) {
              return Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[200],
                padding: EdgeInsets.only(
                  top: 20,
                ),
              );
            } else {
              return Container(
                //margin:EdgeInsets.only(bottom:10),
                width: double.infinity,
                height: 200,
                color: Colors.grey[200],
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child:  ListTile(
                    leading: CircleAvatar(
                      child: Text(
                       dataSnapshot.data.name.toString()[0],
                        style: TextStyle(fontSize: 25),
                      ),
                      backgroundColor: Colors.white,
                      radius: 50,
                    ),
                    title: Text(
                     dataSnapshot.data.name.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      dataSnapshot.data.clubName.toString(),
                    ),
                  ),
              );
            }
          }),
    );
  }
}
