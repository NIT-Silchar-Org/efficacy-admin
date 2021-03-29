import 'package:flutter/material.dart';

class DeveloiperProfile {
  String name;
  // Color cardColor;
  String branch;
  String about;
  String work;
  String imageUrl;
  String fb;
  String linkedin;
  String github;
  String fbFallback;

  DeveloiperProfile({
    @required this.name,
    //@required this.cardColor,
    @required this.branch,
    @required this.fb,
    @required this.imageUrl,
    @required this.about,
    @required this.github,
    @required this.linkedin,
    @required this.work,
    @required this.fbFallback,
  });
}
