import 'package:askforastro/screens/daily_panchang/models/panchang_model.dart';
import 'package:askforastro/screens/daily_panchang/models/places_model.dart';
import 'package:askforastro/screens/home/models/agents_list_model.dart';
import 'package:askforastro/webservice/rest_client.dart';

class PanchangRepo {
  final RestClient _restClient = RestClient();

  Future<PlacesModel> getSearchPlaceList(String query) async {
    return await _restClient.getSearchLocationList(query);
  }

  Future<PanchangModel> getpanchangDetails(Map<String, dynamic> postData) async {
    return await _restClient.getDailyPanchang(postData);
  }
}
