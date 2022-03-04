import 'dart:convert';
import 'package:efficacy_admin/constant/endpoints.dart';
import 'package:efficacy_admin/models/event_model.dart';
import 'package:efficacy_admin/services/network_handler.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  Future<EventModel> fetchEvent(String eventId) async {
    var response =
        await NetworkEngine().post(baseUrl + getevent, {"id": eventId});
    EventModel data =
        EventModel.fromJson(json.decode(json.encode(response.body)));
    return data;
  }

  Future fetchEvents() async {
    var response = await NetworkEngine().post(
        baseUrl + allevents, {"clubList":[]}
    );
    return response.body;
  }
}
