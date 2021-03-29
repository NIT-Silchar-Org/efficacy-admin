import 'package:flutter/material.dart';

class Club {
  String clubId;
  String clubName;
  String description;
  String imageUrl;
  String fb;

  Club({
    @required this.clubId,
    @required this.clubName,
    @required this.description,
    @required this.fb,
    @required this.imageUrl,
  });
}
