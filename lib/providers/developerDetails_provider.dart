import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmApp/models/developers.dart';
import 'package:flutter/cupertino.dart';

class DeveloperDetailProvider with ChangeNotifier {
  final devRef = FirebaseFirestore.instance
      .collection('efficacyTeam/Pr8Rz2CZ2HLURKSoS2mD/developers');

  List<DeveloiperProfile> _developersList(QuerySnapshot snapshot) {
    return snapshot.docs
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
  }

  Future<List<DeveloiperProfile>> get getDeveloperProfile async {
    await devRef.get().then(
          (QuerySnapshot devSnap) => _developersList(devSnap),
        );
  }
}
