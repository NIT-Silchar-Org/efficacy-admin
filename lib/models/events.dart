import 'package:flutter/material.dart';

class Events {
  String about;
  String eventId;
  String clubId;
  String imageUrl;
  DateTime startTime;
  DateTime endTime;
  String title;
  String fbPostLink;
  String googleFormLink;
  //String clubName;
  String venue;

  Events({
    @required this.about,
    this.eventId,
    this.fbPostLink,
    this.googleFormLink,
    @required this.clubId,
    @required this.imageUrl,
    @required this.startTime,
    @required this.endTime,
    @required this.title,
    //@required this.clubName,
    @required this.venue,
  });
}
