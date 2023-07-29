import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/class/game_player.dart';
import 'package:myecl/elocaps/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

class Game {
  Game({required this.id, required this.timestamp, required this.mode,required this.gamePlayers});
  late final String id;
  late final DateTime timestamp;
  late final CapsMode mode;
  late final List<GamePlayer> gamePlayers;

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timestamp = DateTime.parse(json['timestamp']);
    mode = stringToCapsMode(json['mode']);
    gamePlayers = json['game_players'].map((e) => GamePlayer.fromJson(e)).toList();

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['timestamp'] = processDateToAPI(timestamp);
    data['mode'] = capsModeToString(mode);
    data['game_players'] = gamePlayers.map((e) => e.toJson()).toList();

    return data;
  }

  Game copyWith({DateTime? timestamp, CapsMode? mode, String? id, List<GamePlayer>? gamePlayers}) 
  => Game(timestamp: timestamp ?? this.timestamp,
      mode: mode ?? this.mode,
      id: id ?? this.id,
      gamePlayers: gamePlayers ?? this.gamePlayers);

  Game.empty() {
    id = '';
    timestamp = DateTime.now();
    mode = CapsMode.single;
    gamePlayers = [];
  }

  @override
  String toString() {
    return 'Game(id: $id, date de la partie : $timestamp, mode: $mode)';
  }
}
