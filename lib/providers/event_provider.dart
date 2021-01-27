import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/events.dart';

class EventProvider with ChangeNotifier {
  String _clubId;
  static Events _singleEvent;// static to prevent loss of data while refresh/ reload

  EventProvider(this._clubId);

  String get clubId {
    return _clubId;
  }

//generating a list if events of a particular club that we get from [getEventFromClubId()]

  List<Events> _eventList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map(
          (doc) => Events(
            eventId: doc.id,
            title: doc.data()['title'].toString(),
            about: doc.data()['about'].toString(),
            clubId: doc.data()['clubId'].toString(),
            clubName: doc.data()['clubName'].toString(),
            imageUrl: doc.data()['imageUrl'].toString(),
            timeStamp: doc.data()['timestamp'].toString(),
            timings: doc.data()['timings'].toString(),
          ),
        )
        .toList();
  }

  final eventRef = FirebaseFirestore.instance.collection('events');

  Stream<List<Events>> get getEventByClubId {
    print(clubId);
    return eventRef
        .where('clubId', isEqualTo: clubId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(_eventList);
  }

  Future<void> reLoadClubId() async {
    await clubId;
  }

  Future<void> singleEventProvider(String eventId) async {
    //print("got event id: $eventId");
    await eventRef.doc(eventId).get().then(
          (DocumentSnapshot eventSnapshot) => _singleEvent = Events(
            eventId: eventSnapshot.id,
            title: eventSnapshot.data()['title'].toString(),
            about: eventSnapshot.data()['about'].toString(),
            clubId: eventSnapshot.data()['clubId'].toString(),
            clubName: eventSnapshot.data()['clubName'].toString(),
            imageUrl: eventSnapshot.data()['imageUrl'].toString(),
            timeStamp: eventSnapshot.data()['timestamp'].toString(),
            timings: eventSnapshot.data()['timings'].toString(),
          ),
        );
    //print(_singleEvent.about);
   notifyListeners();
  }

  Events get singleEvent {
    return _singleEvent;
  }
}
