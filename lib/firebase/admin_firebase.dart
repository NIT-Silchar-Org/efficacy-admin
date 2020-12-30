import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> userSetup(Map<String,dynamic> adminCredentials) async {
  CollectionReference adminData =
      FirebaseFirestore.instance.collection('clubs');

  print(adminData);

  final Map<String, String> _adminMap = {
    'adminName': adminCredentials['name'].toString(),
    'clubName': adminCredentials['club'].toString(),
    'uid': adminCredentials['uid'].toString(),
    'description': '...',
    'fb': 'fb',
    'imageUrl': 'imageUrl',
    //'clubId': clubId,
  };
  adminData.add(_adminMap);
}
