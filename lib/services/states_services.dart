import 'dart:convert';
import 'package:covid_tracker/model/world_state_model.dart';
import 'package:covid_tracker/services/utlities/app_uri.dart';
import 'package:http/http.dart' as http;

class StateServices {
  //with model
  // this is for world record
  Future<WorldStatesmodel> FetchWorldStateRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesmodel.fromJson(data);
    } else {
      throw Exception("error");
    }
  }

  //without model
  // this is for list of countries
  Future<List<dynamic>> CountriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("error");
    }
  }
}
