import 'dart:convert';

import 'package:covid_tracker/Models/world_states_model.dart';
import 'package:http/http.dart' as http;
import 'app_url.dart';

class StatesServices {
  Future<WorldstatesModel> fetchWorldStatesRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldstatesModel.fromJson(data);
    } else {
      throw Exception(' Error');
    }
  }
}
