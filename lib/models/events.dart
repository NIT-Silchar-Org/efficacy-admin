import 'package:flutter/material.dart';

class Events {
  String about;
  String eventId;
  String clubId;
  String imageUrl;
  String timeStamp;
  String timings;
  String title;
  String clubName;

  Events({
    @required this.about,
    @required this.eventId,
    @required this.clubId,
    @required this.imageUrl,
    @required this.timeStamp,
    @required this.timings,
    @required this.title,
    @required this.clubName,
  });
}
