import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/events.dart';

class EventProvider with ChangeNotifier {
  String _clubId;
  static Events
      _singleEvent; // static to prevent loss of data while refresh/ reload

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
            //clubName: doc.data()['clubName'].toString(),
            imageUrl: doc.data()['picture'].toString(),
            timeStamp: doc.data()['timestamp'].toString() ?? '',
            timings: DateTime.parse(doc.data()['timings'].toString()),
            venue: doc.data()['venue'].toString(),
          ),
        )
        .toList();
  }

  final eventRef = FirebaseFirestore.instance.collection('events');

  Stream<List<Events>> get getEventByClubId {
    print(clubId);
    return eventRef
        .where('clubId', isEqualTo: clubId)
        .where('timestamp', isGreaterThanOrEqualTo: DateTime.now())
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(_eventList);
  }

  //for events that are already completed

  Stream<List<Events>> get getCompletedEvents {
    print(clubId);
    return eventRef
        .where('clubId', isEqualTo: clubId)
        .where('timestamp', isLessThan: DateTime.now())
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(_eventList);
  }

  Future<void> reLoadClubId() async {
    await clubId;
  }

  Future<void> singleEventProvider(String eventId) async {
    await eventRef.doc(eventId).get().then(
          (DocumentSnapshot eventSnapshot) => _singleEvent = Events(
            eventId: eventSnapshot.id,
            title: eventSnapshot.data()['title'].toString(),
            about: eventSnapshot.data()['about'].toString(),
            clubId: eventSnapshot.data()['clubId'].toString(),
            //clubName: eventSnapshot.data()['clubName'].toString(),
            imageUrl: eventSnapshot.data()['picture'].toString() ?? '',
            timeStamp: eventSnapshot.data()['timestamp'].toString(),
            timings: DateTime.parse(eventSnapshot.data()['timings'].toString()),
            venue: eventSnapshot.data()['venue'].toString(),
          ),
        );
    notifyListeners();
  }

//to add a new event
  Future<void> addEvent(Events _event) async {
    final Map<String, Object> _eventData = {
      'about': _event.about,
      'title': _event.title,
      'clubId': _clubId,
      'picture': _event.imageUrl,
      'timings': _event.timings,
      'timestamp': _event.timeStamp,
      'venue': _event.venue,
    };
    await eventRef.add(_eventData);
  }

  Events get singleEvent {
    return _singleEvent;
  }
}
