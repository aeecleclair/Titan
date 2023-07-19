import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

class Game {
  Game({required this.id, required this.timestamp, required this.mode});
  late final String id;
  late final DateTime timestamp;
  late final CapsMode mode;

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timestamp = DateTime.parse(json['timestamp']);
    mode = stringToCapsMode(json['mode']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['timestamp'] = processDateToAPI(timestamp);
    data['mode'] = capsModeToString(mode);
    return data;
  }

  Game copyWith({DateTime? timestamp, CapsMode? mode, String? id}) 
  => Game(timestamp: timestamp ?? this.timestamp,
      mode: mode ?? this.mode,
      id: id ?? this.id);

  Game.empty() {
    id = '';
    timestamp = DateTime.now();
    mode = CapsMode.single;
  }

  @override
  String toString() {
    return 'Game(id: $id, date de la partie : $timestamp, mode: $mode)';
  }
}
