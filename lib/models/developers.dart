import 'package:flutter/material.dart';

class DeveloiperProfile {
  String name;
  // Color cardColor;
  String branch;
  String designation;
  String imageUrl;
  String fb;
  String linkedin;
  String fbFallback;

  DeveloiperProfile({
    @required this.name,
    //@required this.cardColor,
    @required this.branch,
    @required this.fb,
    @required this.imageUrl,
    @required this.linkedin,
    @required this.designation,
    @required this.fbFallback,
  });
}
