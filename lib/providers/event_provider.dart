import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/events.dart';

class EventProvider with ChangeNotifier {
  String clubId;

  EventProvider(this.clubId);

  List<Events> _eventsList = [];

  List<Events> get eventList {
    return [..._eventsList];
  }

  final eventRef = FirebaseFirestore.instance.collection('events');

  Future<void> getEventByClubId() async {
    List<Events> _loadedEvents = [];

    await eventRef.get().then((QuerySnapshot eventSnapshot) {
      // _loadedEvents.add();
      _loadedEvents = eventSnapshot.docs.where((QueryDocumentSnapshot event) {
        return event.data()['clubId'] == clubId;
      }).map((event) {
        return Events(
            eventId: event.id,
            about: event.data()['about'].toString(),
            clubId: event.data()['clubId'].toString(),
            clubName: event.data()['clubName'].toString(),
            imageUrl: event.data()['picture'].toString(),
            timeStamp: DateTime.now(),
            timings: DateTime.now(),
            title: event.data()['title'].toString());
      }).toList();
    });
    _eventsList = _loadedEvents;
    notifyListeners();
    //print(_eventsList[0].about);
  }

//  void fetchAndSetEventList(){

//  }

}
