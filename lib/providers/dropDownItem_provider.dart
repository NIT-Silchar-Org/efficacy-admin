import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DropdownItems with ChangeNotifier {
  final clubRef = FirebaseFirestore.instance.collection('clubs');

  Future<void> loadClubs() async {
    List<String> loadedClubs = [];
    await clubRef.get().then((QuerySnapshot clubSnapshot) {
      clubSnapshot.docs.forEach((DocumentSnapshot clubId) {
        //print(clubId.id);
        loadedClubs.add(clubId.data()['name'].toString());
      });
    });
    _clubList = loadedClubs;
  }

  List<String> _clubList = [];

  List<String> get clubList {
    return [..._clubList];
  }

  List<String> _branchList = [
    'CE',
    'CSE',
    'ECE',
    'EE',
    'E&I',
    'ME',
  ];

  List<String> get branchList {
    return [..._branchList];
  }
}
