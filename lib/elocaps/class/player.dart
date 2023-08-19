import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/tools/functions.dart';

class Player{
  Player({
    required this.mode,
    required this.elo,
    required this.id,
  });
  late final CapsMode mode;
  late final int elo;
  late final String id;

  Player.fromJson(Map<String, dynamic> json) {
    mode = stringToCapsMode(json['mode']);
    elo = json['elo'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mode'] = capsModeToString(mode);
    data['elo'] = elo;
    data['id'] = id;
    return data;
  }

  Player copyWith({
    CapsMode? mode,
    int? elo,
    String? id,
  }) => Player(
    id: id ?? this.id,
    mode: mode ?? this.mode,
    elo: elo ?? this.elo,
  );

  Player.empty() {
    mode = CapsMode.single;
    elo = 0;
    id = "";
  }

  @override
  String toString() {
    return 'elo: $elo,mode: $mode,id: $id';
  }
}