
import 'package:askforastro/screens/home/models/agents_list_model.dart';
import 'package:askforastro/webservice/rest_client.dart';

class AgentListRepo {
  final RestClient _restClient = RestClient();

  Future<AgentsListModel> getAllAgentListRepo() async {
    return await _restClient.getAllAgentList();
  }
}