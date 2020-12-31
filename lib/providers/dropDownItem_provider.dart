import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DropdownItems with ChangeNotifier {
  final clubRef = FirebaseFirestore.instance.collection('clubs');

  Future<void> loadClubs() async {
    List<String> loadedClubs = [];
    List<String> loadedClubIds = [];
    await clubRef.get().then((QuerySnapshot clubSnapshot) {
      clubSnapshot.docs.forEach((DocumentSnapshot clubId) {
        //print(clubId.id);
        loadedClubs.add(clubId.data()['name'].toString());
        loadedClubIds.add(clubId.id.toString());
      });
    });
    _clubList = loadedClubs;
    _clubIdList = loadedClubIds;
  }

  String getClubIdByName(String clubName) {
    String clubId;
    int clubIndex;
    clubIndex = _clubList.indexWhere((club) => club == clubName);
    return _clubIdList[clubIndex];
  }

//List of Clubs
  List<String> _clubList = [];

  List<String> get clubList {
    return [..._clubList];
  }

  //List of club Ids

  List<String> _clubIdList = [];

  List<String> get clubIdList {
    return [..._clubIdList];
  }

//List of branch
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
