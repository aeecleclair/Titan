import 'package:myecl/user/class/list_users.dart';

class GamePlayer {
  GamePlayer(
      {required this.playerId,
      required this.eloGain,
      required this.team,
      required this.quarters,
      required this.user});

  late final String playerId;
  late final int eloGain;
  late final int team;
  late final int quarters;
  late final SimpleUser user;

  GamePlayer.fromJson(Map<String, dynamic> json) {
    playerId = json['user_id'];
    eloGain = json['elo_gain'];
    team = json['team'];
    quarters = json['quarters'];
    user = SimpleUser.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = playerId;
    data['elo_gain'] = eloGain;
    data['team'] = team;
    data['quarters'] = quarters;
    data['user'] = user.toJson();
    return data;
  }

  Map<String, dynamic> toJsonForCreate() {
    final data = <String, dynamic>{};
    data['user_id'] = playerId;
    data['team'] = team;
    data['quarters'] = quarters;
    return data;
  }

  GamePlayer copyWith({
    String? playerId,
    int? eloGain,
    int? team,
    int? quarters,
    SimpleUser? user,
  }) =>
      GamePlayer(
        playerId: playerId ?? this.playerId,
        eloGain: eloGain ?? this.eloGain,
        team: team ?? this.team,
        quarters: quarters ?? this.quarters,
        user: user ?? this.user,
      );

  GamePlayer.empty() {
    playerId = '';
    eloGain = 0;
    team = 1;
    quarters = 0;
    user = SimpleUser.empty();
  }

  @override
  String toString() {
    return 'GamePlayer(playerId: $playerId, elo_gain: $eloGain, team: $team, quarters: $quarters, user: ${user.toString()})';
  }
}
