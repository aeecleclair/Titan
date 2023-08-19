import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/class/game_player.dart';
import 'package:myecl/elocaps/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

class Game {
  Game({required this.id, required this.timestamp, required this.mode,required this.gamePlayers,required this.isConfirmed});
  late final String id;
  late final DateTime timestamp;
  late final CapsMode mode;
  late final List<GamePlayer> gamePlayers;
  late final bool isConfirmed;

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timestamp = DateTime.parse(json['timestamp']);
    mode = stringToCapsMode(json['mode']);
    gamePlayers = json['game_players'].map<GamePlayer>((e) => GamePlayer.fromJson(e)).toList();
    isConfirmed = json['is_confirmed'];

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['timestamp'] = processDateToAPI(timestamp);
    data['mode'] = capsModeToString(mode);
    data['game_players'] = gamePlayers.map((e) => e.toJson()).toList();
    data['is_confirmed'] = isConfirmed.toString();

    return data;
  }

  Game copyWith({DateTime? timestamp, CapsMode? mode, String? id, List<GamePlayer>? gamePlayers, bool? isConfirmed}) 
  => Game(timestamp: timestamp ?? this.timestamp,
      mode: mode ?? this.mode,
      id: id ?? this.id,
      gamePlayers: gamePlayers ?? this.gamePlayers,
      isConfirmed: isConfirmed ?? this.isConfirmed);

  Game.empty() {
    id = '';
    timestamp = DateTime.now();
    mode = CapsMode.single;
    gamePlayers = [];
    isConfirmed = false;
  }

  @override
  String toString() {
    return 'Game(id: $id, date de la partie : $timestamp, mode: $mode, isConfirmed : $isConfirmed)';
  }
}
