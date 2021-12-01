import 'package:assignment/src/home/models/tournament_response_model.dart';
import 'dio_methods.dart';

class RestClient {
  RestClient();

  Future<TournamentResponseModel> getTournamentData(
      int limit, String cursor) async {
    Map<String, dynamic>? rMap = await DioMethod.dioGet(
        'tournament/api/tournaments_list_v2?status=all&cursor=$cursor&limit=$limit');
    return TournamentResponseModel.fromJson(rMap!);
  }
}
