import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> userSetup(String adminName, String clubName, String uid,
    String description, String fb, String imageUrl) async {
  CollectionReference adminData =
      FirebaseFirestore.instance.collection('clubs');

  print(adminData);

  final Map<String, String> _adminMap = {
    'adminName': adminName,
    'clubName': clubName,
    'uid': uid,
    'description': description,
    'fb': fb,
    'imageUrl': imageUrl,
    //'clubId': clubId,
  };
  adminData.add(_adminMap);
}
