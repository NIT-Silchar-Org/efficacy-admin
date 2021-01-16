// import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../models/adminProfile.dart';

// class AdminProvider with ChangeNotifier {
//   String adminId;

//   AdminProvider(this.adminId);

//   final CollectionReference adminRef =
//       FirebaseFirestore.instance.collection('admins');

//   Stream<AdminProfile> get adminProfile {
//     return adminRef.doc(adminId).snapshots().first as AdminProfile;
//   }

//   // Stream<AdminProfile> get getEventByClubId {
//   //   return adminRef.where('uid', isEqualTo: userId).snapshots().map(_adminProfile);
//   //   // .map(_adminProfile);
//   // }
// }
