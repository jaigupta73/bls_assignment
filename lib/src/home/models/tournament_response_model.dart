class TournamentResponseModel {
  TournamentResponseModel({
    required this.code,
    required this.data,
    required this.success,
    required this.errorRes
  });

  late final int code;
  late final Data data;
  late final ErrorRes errorRes;
  late final bool success;

  TournamentResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    if (success) {
      data = Data.fromJson(json['data']);
    }else
      {
        errorRes = ErrorRes.fromJson(json['data']);
      }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['data'] = data.toJson();
    _data['success'] = success;
    return _data;
  }
}

class ErrorRes{
  ErrorRes({required this.errorMsg});
  late final String errorMsg;
  ErrorRes.fromJson(Map<String, dynamic> json) {
    errorMsg = json['error'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = errorMsg;

    return _data;
  }
}

class Data {
  Data({
    required this.cursor,
    this.tournamentCount,
    required this.tournaments,
    required this.isLastBatch,
  });

  late final String cursor;
  late final Null tournamentCount;
  late final List<Tournaments> tournaments;
  late final bool isLastBatch;

  Data.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    tournamentCount = null;
    tournaments = List.from(json['tournaments'])
        .map((e) => Tournaments.fromJson(e))
        .toList();
    isLastBatch = json['is_last_batch'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cursor'] = cursor;
    _data['tournament_count'] = tournamentCount;
    _data['tournaments'] = tournaments.map((e) => e.toJson()).toList();
    _data['is_last_batch'] = isLastBatch;
    return _data;
  }
}

class Tournaments {
  Tournaments({
    required this.name,
    required this.coverUrl,
    required this.gameName,
  });

  late final String name;

  late final String? coverUrl;

  late final String gameName;

  Tournaments.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    coverUrl = json['cover_url'];

    gameName = json['game_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['name'] = name;

    _data['cover_url'] = coverUrl;

    _data['game_name'] = gameName;

    return _data;
  }
}
