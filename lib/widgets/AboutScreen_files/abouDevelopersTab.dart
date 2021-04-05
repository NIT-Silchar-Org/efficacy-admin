import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmApp/models/developers.dart';
import 'package:cmApp/utilities/loadingSpinner.dart';
import 'package:cmApp/widgets/AboutScreen_files/teamProfileCard.dart';
import 'package:flutter/material.dart';

class AboutdevelopersTab extends StatelessWidget {
  static List<dynamic> devProfile;
  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return FutureBuilder(
      initialData:devProfile=devProfile,
      future: FirebaseFirestore.instance
          .collection('efficacyTeam/Pr8Rz2CZ2HLURKSoS2mD/developers')
          .get(),
      builder: (ctx, devSnap) {
        if (devSnap.connectionState == ConnectionState.waiting)
          return devProfile == null
              ? LoadingSpinner()
              : ListView.builder(
                  itemBuilder: (ctx, index) => TeamProfileCard(
                      devProfile[index] as DeveloiperProfile, deviceSize),
                  itemCount: devProfile.length,
                );
        if (devSnap.hasData) {
          devProfile = devSnap.data.docs
              .map(
                (doc) => DeveloiperProfile(
                  name: doc.data()['name'].toString(),
                  //cardColor: doc.data()['color'] as Color,
                  branch: doc.data()['branch'].toString(),
                  fb: doc.data()['facebook'].toString(),
                  imageUrl: doc.data()['imageUrl'].toString(),
                  linkedin: doc.data()['linkedIn'].toString(),
                  designation: doc.data()['designation'].toString(),
                  fbFallback: doc.data()['fbFallback'].toString(),
                ),
              )
              .toList();
          return ListView.builder(
            itemBuilder: (ctx, index) => TeamProfileCard(
                devProfile[index] as DeveloiperProfile, deviceSize),
            itemCount: devProfile.length,
          );
        } else
          return Text("Error");
      },
    );
  }
}
