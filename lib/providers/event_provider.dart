import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/events.dart';

class EventProvider with ChangeNotifier {
  String _clubId;

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
}
