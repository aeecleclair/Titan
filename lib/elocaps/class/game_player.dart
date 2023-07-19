
class GamePlayer{
  GamePlayer({required this.gameId, required this.playerId, required this.eloGain, required this.hasConfirmed});

  late final String gameId;
  late final String playerId;
  late final int eloGain;
  late final bool hasConfirmed;

  GamePlayer.fromJson(Map<String, dynamic> json) {
    gameId = json['gameId'];
    playerId = json['playerId'];
    eloGain = json['eloGain'];
    hasConfirmed = json['hasConfirmed'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['gameId'] = gameId;
    data['playerId'] = playerId;
    data['eloGain'] = eloGain;
    data['hasConfirmed'] = hasConfirmed;
    return data;
  }

  GamePlayer copyWith({
    String? gameId,
    String? playerId,
    int? eloGain,
    bool? hasConfirmed,
  }) => GamePlayer(
    gameId: gameId ?? this.gameId,
    playerId: playerId ?? this.playerId,
    eloGain: eloGain ?? this.eloGain,
    hasConfirmed: hasConfirmed ?? this.hasConfirmed,
  );

  GamePlayer.empty() {
    gameId = '';
    playerId = '';
    eloGain = 0;
    hasConfirmed = false;
  }

  @override
  String toString() {
    return 'GamePlayer(gameId: $gameId, playerId: $playerId, eloGain: $eloGain, Confirmé ? : $hasConfirmed)';
  }
}