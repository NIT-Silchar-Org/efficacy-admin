import 'dart:convert';
import 'package:efficacy_admin/constant/endpoints.dart';
import 'package:efficacy_admin/models/club_model.dart';
import 'package:efficacy_admin/services/network_handler.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  Future<String> fetchContact(String clubId) async {
    var response =
        await NetworkEngine().post(baseUrl + getclubdetails + clubId, {});
    // ClubModel data =
    //     ClubModel.fromJson(json.decode(json.encode(response.body)));
    print(response.body);
    return response.body;
  }
}
