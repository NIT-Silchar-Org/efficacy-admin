import 'package:flutter/material.dart';

class Events {
  String about;
  String eventId;
  String clubId;
  String imageUrl;
  String timeStamp;
  DateTime timings;
  String title;
  //String clubName;
  String venue;

  Events({
    @required this.about,
    this.eventId,
    @required this.clubId,
    @required this.imageUrl,
    @required this.timeStamp,
    @required this.timings,
    @required this.title,
    //@required this.clubName,
    @required this.venue,
  });
}
