class User {
  User({
    required this.data,
  });

  late final List<Data> data;

  User.fromJson(Map<String, dynamic> json) {
    data = List.from(json['user']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.tournamentWon,
    required this.tournamentPlayed,
    required this.winningPercentage,
    required this.rating,
    required this.profileImage,
  });

  late final int id;
  late final String username;
  late final String password;
  late final String name;
  late final String tournamentPlayed;
  late final String tournamentWon;
  late final String winningPercentage;
  late final String rating;
  late final String profileImage;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    name = json['name'];
    tournamentPlayed = json['tournament_played'];
    tournamentWon = json['tournament_won'];
    winningPercentage = json['winning_percentage'];
    profileImage = json['profile_image'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['password'] = password;
    _data['name'] = name;
    _data['winning_percentage'] = winningPercentage;
    _data['tournament_won'] = tournamentWon;
    _data['tournament_played'] = tournamentPlayed;
    _data['profile_image'] = profileImage;
    _data['rating'] = rating;
    return _data;
  }
}
