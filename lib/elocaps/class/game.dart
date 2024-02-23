import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/class/game_player.dart';
import 'package:myecl/elocaps/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

class Game {
  Game(
      {required this.id,
      required this.timestamp,
      required this.mode,
      required this.gamePlayers,
      required this.isConfirmed,
      required this.isCancelled});
  late final String id;
  late final DateTime timestamp;
  late final CapsMode mode;
  late final List<GamePlayer> gamePlayers;
  late final bool isConfirmed;
  late final bool isCancelled;

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timestamp = DateTime.parse(json['timestamp']);
    mode = stringToCapsMode(json['mode']);
    gamePlayers = json['game_players']
        .map<GamePlayer>((e) => GamePlayer.fromJson(e))
        .toList();
    isConfirmed = json['is_confirmed'];
    isCancelled = json['cancelled'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['timestamp'] = processDateToAPI(timestamp);
    data['mode'] = apiCapsModeToString(mode);
    data['game_players'] = gamePlayers.map((e) => e.toJson()).toList();
    data['is_confirmed'] = isConfirmed.toString();
    data['cancelled'] = isCancelled.toString();
    return data;
  }

  Map<String, dynamic> toJsonForCreate() {
    final data = <String, dynamic>{};
    data['mode'] = apiCapsModeToString(mode);
    data['players'] = gamePlayers.map((e) => e.toJsonForCreate()).toList();
    return data;
  }

  Game copyWith(
          {DateTime? timestamp,
          CapsMode? mode,
          String? id,
          List<GamePlayer>? gamePlayers,
          bool? isConfirmed,
          bool? isCancelled}) =>
      Game(
          timestamp: timestamp ?? this.timestamp,
          mode: mode ?? this.mode,
          id: id ?? this.id,
          gamePlayers: gamePlayers ?? this.gamePlayers,
          isConfirmed: isConfirmed ?? this.isConfirmed,
          isCancelled: isCancelled ?? this.isCancelled);

  Game.empty() {
    id = '';
    timestamp = DateTime.now();
    mode = CapsMode.single;
    gamePlayers = [];
    isConfirmed = false;
    isCancelled = false;
  }

  @override
  String toString() {
    return 'Game(id: $id, date de la partie : $timestamp, mode: $mode, isConfirmed : $isConfirmed), isCancelled : $isCancelled';
  }
}
