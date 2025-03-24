import 'package:myecl/user/class/list_users.dart';

class MemeScore {
  late final int score;
  late final int position;

  MemeScore({
    required this.score,
    required this.position,
  });

  MemeScore.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    position = json['position'];
  }

  MemeScore.empty() {
    score = 0;
    position = 0;
  }

  @override
  String toString() => "Votre position est $position avec un score de $score";
}

class MemeScoreUser extends MemeScore {
  late final SimpleUser user;

  MemeScoreUser({
    required this.user,
    required super.score,
    required super.position,
  });

  MemeScoreUser.fromJson(super.json)
      : user = SimpleUser.fromJson(json['user']),
        super.fromJson();

  MemeScoreUser.empty()
      : user = SimpleUser.empty(),
        super.empty();

  @override
  String toString() => 'Score(user: $user, value: $score, position: $position)';
}

class MemeScorePromo extends MemeScore {
  late final int promo;

  MemeScorePromo({
    required this.promo,
    required super.score,
    required super.position,
  });

  MemeScorePromo.fromJson(super.json)
      : promo = json['promo'],
        super.fromJson();

  MemeScorePromo.empty()
      : promo = 0,
        super.empty();

  @override
  String toString() =>
      'Score(promo: $promo, value: $score, position: $position)';
}

class MemeScoreFloor extends MemeScore {
  late final String floor;

  MemeScoreFloor({
    required this.floor,
    required super.score,
    required super.position,
  });

  MemeScoreFloor.fromJson(super.json)
      : floor = json['floor'] ?? "",
        super.fromJson();

  MemeScoreFloor.empty()
      : floor = "",
        super.empty();

  @override
  String toString() =>
      'Score(floor: $floor, value: $score, position: $position)';
}
