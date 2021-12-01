import 'package:assignment/src/home/models/tournament_response_model.dart';
import 'package:assignment/src/webservicemethods/rest_client.dart';

class TournamentRepo {
  final RestClient _restClient = RestClient();

  Future<TournamentResponseModel> getTournamentRepo(int limit,String cursor) async {
    return await _restClient.getTournamentData(limit,cursor);
  }
}