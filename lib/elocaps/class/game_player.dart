
class GamePlayer{
  GamePlayer({required this.gameId, required this.playerId, required this.eloGain, required this.hasConfirmed});

  late final String gameId;
  late final String playerId;
  late final int eloGain;
  late final bool hasConfirmed;
}