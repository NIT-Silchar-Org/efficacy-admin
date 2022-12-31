import 'dart:convert';
import 'package:efficacy_admin/constant/constant.dart';
import 'package:efficacy_admin/constant/endpoints.dart';
import 'package:efficacy_admin/models/event_model.dart';
import 'package:efficacy_admin/services/network_handler.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  Future fetchEvent(String eventId) async {
    var response =
        await NetworkEngine().post(baseUrl + getevent, {"id": eventId});
    // EventModel data =
    //     EventModel.fromJson(json.decode(json.encode(response.body)));
    return response.body;
  }

  Future fetchEvents(List<String> clubid) async {
    var response =
        await NetworkEngine().post(baseUrl + allevents, {"clubList": clubid});
    print(response.body);
    return response.body;
  }

  Future addEvent(Map<String, dynamic> data) async {
    var response = await NetworkEngine().post(baseUrl + addevent, data);
    return response.body;
  }

  Future editEvent(Map<String, dynamic> data, String id) async {
    var response = await NetworkEngine().post(baseUrl + editevent + id, data);
    return response.body;
  }
}
