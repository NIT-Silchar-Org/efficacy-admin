import 'package:flutter/material.dart';

class AdminProfile {
 // String uid;
  String clubName;
  String name;
  String description;
  String imageUrl;
  String fb;
  String branch;

  AdminProfile({
    @required this.name,
    @required this.clubName,
    @required this.description,
    @required this.fb,
    @required this.imageUrl,
   // @required this.uid,
    @required this.branch,
  });
}
