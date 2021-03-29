import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmApp/models/developers.dart';
import 'package:flutter/cupertino.dart';

class DeveloperDetailProvider with ChangeNotifier {
  final devRef = FirebaseFirestore.instance.collection('developers');

  List<DeveloiperProfile> _developersList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map(
          (doc) => DeveloiperProfile(
            name: doc.data()['name'].toString(),
            //cardColor: doc.data()['color'] as Color,
            branch: doc.data()['branch'].toString(),
            fb: doc.data()['fb'].toString(),
            imageUrl: doc.data()['imageUrl'].toString(),
            about: doc.data()['about'].toString(),
            github: doc.data()['github'].toString(),
            linkedin: doc.data()['linkedin'].toString(),
            work: doc.data()['work'].toString(),
            fbFallback: doc.data()['fbFallback'].toString(),
          ),
        )
        .toList();
  }

  Stream<List<DeveloiperProfile>> get getDeveloperProfile {
    return devRef
        .orderBy('name', descending: false)
        .snapshots()
        .map(_developersList);
  }
}
