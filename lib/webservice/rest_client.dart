

import 'package:askforastro/screens/daily_panchang/models/panchang_model.dart';
import 'package:askforastro/screens/daily_panchang/models/places_model.dart';
import 'package:askforastro/screens/home/models/agents_list_model.dart';

import 'dio_methods.dart';

class RestClient {
  RestClient();

  Future<AgentsListModel> getAllAgentList() async {
    Map<String, dynamic>? rMap = await DioMethod.dioGet('astroapi/api/agent/all');
    return AgentsListModel.fromJson(rMap!);
  }

  Future<PlacesModel> getSearchLocationList(String query) async {
    Map<String, dynamic>? rMap = await DioMethod.dioGet('astroapi/api/location/place?inputPlace=$query');
    return PlacesModel.fromJson(rMap!);
  }

  Future<PanchangModel> getDailyPanchang(Map<String, dynamic> postData) async {
    Map<String, dynamic>? rMap = await DioMethod.dioPost('astroapi/api/horoscope/daily/panchang',postData);
    return PanchangModel.fromJson(rMap!);
  }
}
