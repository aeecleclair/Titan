import 'package:myecl/user/class/list_users.dart';

class CMMScore {
  late final SimpleUser user;
  late final int score;
  late final int position;

  CMMScore({
    required this.user,
    required this.score,
    required this.position,
  });

  CMMScore.fromJson(Map<String, dynamic> json) {
    user = SimpleUser.fromJson(json['user']);
    score = json['score'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user.id;
    data['score'] = score;
    return data;
  }

  CMMScore copyWith({
    SimpleUser? user,
    int? score,
    DateTime? date,
    int? position,
  }) {
    return CMMScore(
      user: user ?? this.user,
      score: score ?? this.score,
      position: position ?? this.position,
    );
  }

  CMMScore.empty() {
    user = SimpleUser.empty();
    score = 0;
    position = 0;
  }

  @override
  String toString() => 'Score(user: $user, value: $score, position: $position)';
}
