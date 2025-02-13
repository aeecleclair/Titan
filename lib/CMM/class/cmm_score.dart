import 'package:myecl/user/class/list_users.dart';

class CMMScoreUser {
  late final SimpleUser user;
  late final int score;
  late final int position;

  CMMScoreUser({
    required this.user,
    required this.score,
    required this.position,
  });

  CMMScoreUser.fromJson(Map<String, dynamic> json) {
    user = SimpleUser.fromJson(json['user']);
    score = json['score'];
    position = json['position'];
  }

  CMMScoreUser.empty() {
    user = SimpleUser.empty();
    score = 0;
    position = 0;
  }

  @override
  String toString() => 'Score(user: $user, value: $score, position: $position)';
}

class CMMScorePromo {
  late final int promo;
  late final int score;
  late final int position;

  CMMScorePromo({
    required this.promo,
    required this.score,
    required this.position,
  });

  CMMScorePromo.fromJson(Map<String, dynamic> json) {
    promo = json['promo'];
    score = json['score'];
    position = json['position'];
  }

  CMMScorePromo.empty() {
    promo = 0;
    score = 0;
    position = 0;
  }

  @override
  String toString() =>
      'Score(promo: $promo, value: $score, position: $position)';
}

class CMMScoreFloor {
  late final String floor;
  late final int score;
  late final int position;

  CMMScoreFloor({
    required this.floor,
    required this.score,
    required this.position,
  });

  CMMScoreFloor.fromJson(Map<String, dynamic> json) {
    floor = json['floor'];
    score = json['score'];
    position = json['position'];
  }

  CMMScoreFloor.empty() {
    floor = "";
    score = 0;
    position = 0;
  }

  @override
  String toString() =>
      'Score(floor: $floor, value: $score, position: $position)';
}
