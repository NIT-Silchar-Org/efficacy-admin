import 'package:flutter/material.dart';

import '../widgets/iconBadge.dart';
import '../widgets/profileFieldMaker.dart';
import '../widgets/profilePic.dart';


class UserProfileScreen extends StatelessWidget {
  static const routeName = '/user-profile-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 720,
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: IconBadge(
                  icon: Icons.camera_alt,
                  child: ProfilePic(),
                  color: Colors.grey,
                ),
              ),
              ProfileFieldMaker(
                fieldTitle: 'Name',
                fieldPreValue: 'Apoorv Aadarsh',
                fieldIcon: Icons.person,
                description:
                    'This is your username.This name will be visible to everyone',
              ),
              ProfileFieldMaker(
                fieldTitle: 'Email',
                fieldPreValue: 'apoorvsahay10@gmail.com',
                fieldIcon: Icons.mail,
                description:
                    'This is your mail id, this will only be visible to you',
              ),
              ProfileFieldMaker(
                fieldTitle: 'Phone Number',
                fieldPreValue: '9876543210',
                fieldIcon: Icons.phone,
                description:
                    'Your phone numbwe will be used for identification purpose.Phone number will only be visible to you.',
                countryCode: true,
              ),
              ProfileFieldMaker(
                fieldTitle: 'Scholar Id',
                fieldPreValue: '1911148',
                fieldIcon: Icons.perm_contact_calendar,
                description: 'Your scholar id will be visible to everyone',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
