import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/club.dart';

class ClubDetailsProvider with ChangeNotifier {
  String _clubId;
  String _clubName;
  String _description;
  String _fb;
  String _imageUrl;
  bool _isClubDataLoading = true;
  String token;
  String uid;

  // QueryDocumentSnapshot admin;

  ClubDetailsProvider({@required this.uid});

  final adminRef = FirebaseFirestore.instance.collection('admins');
  final clubRef = FirebaseFirestore.instance.collection('clubs');

//to get clubId

  Future<void> _fetchClubIdByUserId() async {
    await adminRef.get().then<void>((QuerySnapshot adminSnapshot) {
      _clubId = adminSnapshot.docs
          .firstWhere((QueryDocumentSnapshot admins) {
            return admins.id == uid;
          })
          .data()['clubId']
          .toString();
      print(_clubId);
      // clubId = admin.data()['clubId'].toString();
    });
  }

//clubId
  String get clubId {
    return _clubId;
  }

  Future<void> fetchAndSetClubDetails() async {
    await _fetchClubIdByUserId().then((_) {
      clubRef.get().then((QuerySnapshot clubSnapshot) {
        print(clubSnapshot);
        return clubSnapshot.docs
            .firstWhere((QueryDocumentSnapshot clubs) => clubId == clubs.id);
      }).then((QueryDocumentSnapshot club) {
        print(club.data()['name']);
        _clubId = club.id;
        _clubName = club.data()['name'].toString();
        _description = club.data()['desc'].toString();
        _fb = club.data()['fb'].toString();
        _imageUrl = club.data()['imageUrl'].toString();
      }).then((_) {
        _isClubDataLoading = false;
        notifyListeners();
      });
    });
  }

  String get clubName {
    return _clubName;
  }

  String get description {
    return _description;
  }

  String get fb {
    return _fb;
  }

  String get imageUrl {
    return _imageUrl;
  }

  bool get isClubDataLoading {
    return _isClubDataLoading;
  }
}
