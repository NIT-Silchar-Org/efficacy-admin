import 'package:flutter/material.dart';

class AdminProfile {
  String clubName;
  String name;
  String email;
  String fb;
  String linkedin;
  String branch;

  AdminProfile({
    @required this.name,
    @required this.clubName,
    @required this.linkedin,
    @required this.fb,
    @required this.email,
    @required this.branch,
  });
}
