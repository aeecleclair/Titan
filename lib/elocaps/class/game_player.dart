import 'package:myecl/user/class/list_users.dart';

class GamePlayer {
  GamePlayer(
      {required this.playerId,
      required this.eloGain,
      required this.team,
      required this.hasConfirmed,
      required this.score,
      required this.user});

  late final String playerId;
  late final int eloGain;
  late final int team;
  late final bool hasConfirmed;
  late final int score;
  late final SimpleUser user;

  GamePlayer.fromJson(Map<String, dynamic> json) {
    playerId = json['user_id'];
    eloGain = json['elo_gain'];
    team = json['team'];
    hasConfirmed = json['has_confirmed'];
    score = json['score'];
    user = SimpleUser.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = playerId;
    data['elo_gain'] = eloGain;
    data['team'] = team;
    data['has_confirmed'] = hasConfirmed;
    data['score'] = score;
    data['user'] = user.toJson();
    return data;
  }

  Map<String, dynamic> toJsonForCreate() {
    final data = <String, dynamic>{};
    data['user_id'] = playerId;
    data['team'] = team;
    data['has_confirmed'] = hasConfirmed;
    data['score'] = score;
    return data;
  }

  GamePlayer copyWith({
    String? playerId,
    int? eloGain,
    int? team,
    bool? hasConfirmed,
    int? score,
    SimpleUser? user,
  }) =>
      GamePlayer(
        playerId: playerId ?? this.playerId,
        eloGain: eloGain ?? this.eloGain,
        team: team ?? this.team,
        hasConfirmed: hasConfirmed ?? this.hasConfirmed,
        score: score ?? this.score,
        user: user ?? this.user,
      );

  GamePlayer.empty() {
    playerId = '';
    eloGain = 0;
    team = 1;
    hasConfirmed = false;
    score = 0;
    user = SimpleUser.empty();
  }

  @override
  String toString() {
    return 'GamePlayer(playerId: $playerId, elo_gain: $eloGain, team: $team, has_confirmed : $hasConfirmed ,score: $score, user: ${user.toString()})';
  }
}
