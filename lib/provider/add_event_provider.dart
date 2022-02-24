import 'package:efficacy_admin/models/add_event_model.dart';
import 'package:flutter/cupertino.dart';

import '../services/service.dart';

class DevProvider with ChangeNotifier {
  Future<AddEventModel> fetchDevs() async {
    try {
      const newendpoint = "localhost:3000/addEvent";

      final response =
          await NetworkEngine().post(endPoint: newendpoint, data: {});
      var details = response.data['data'];
      AddEventModel event = AddEventModel.fromJson(details);
      return event;
    } catch (e) {
      rethrow;
    }
  }
}
