import 'package:myecl/user/class/list_users.dart';

class CMMScore {
  late final int score;
  late final int position;

  CMMScore({
    required this.score,
    required this.position,
  });

  CMMScore.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    position = json['position'];
  }

  CMMScore.empty() {
    score = 0;
    position = 0;
  }

  @override
  String toString() => "Votre position est $position avec un score de $score";
}

class CMMScoreUser extends CMMScore {
  late final SimpleUser user;

  CMMScoreUser({
    required this.user,
    required super.score,
    required super.position,
  });

  CMMScoreUser.fromJson(super.json)
      : user = SimpleUser.fromJson(json['user']),
        super.fromJson();

  CMMScoreUser.empty()
      : user = SimpleUser.empty(),
        super.empty();

  @override
  String toString() => 'Score(user: $user, value: $score, position: $position)';
}

class CMMScorePromo extends CMMScore {
  late final int promo;

  CMMScorePromo({
    required this.promo,
    required super.score,
    required super.position,
  });

  CMMScorePromo.fromJson(super.json)
      : promo = json['promo'],
        super.fromJson();

  CMMScorePromo.empty()
      : promo = 0,
        super.empty();

  @override
  String toString() =>
      'Score(promo: $promo, value: $score, position: $position)';
}

class CMMScoreFloor extends CMMScore {
  late final String floor;

  CMMScoreFloor({
    required this.floor,
    required super.score,
    required super.position,
  });

  CMMScoreFloor.fromJson(super.json)
      : floor = json['floor'] ?? "",
        super.fromJson();

  CMMScoreFloor.empty()
      : floor = "",
        super.empty();

  @override
  String toString() =>
      'Score(floor: $floor, value: $score, position: $position)';
}
