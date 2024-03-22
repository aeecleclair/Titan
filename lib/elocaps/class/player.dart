import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/tools/functions.dart';
import 'package:myecl/user/class/list_users.dart';

class Player {
  Player({
    required this.mode,
    required this.elo,
    required this.user,
  });
  late final CapsMode mode;
  late final int elo;
  late final SimpleUser user;

  Player.fromJson(Map<String, dynamic> json) {
    mode = stringToCapsMode(json['mode']);
    elo = json['elo'];
    user = SimpleUser.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mode'] = apiCapsModeToString(mode);
    data['elo'] = elo;
    data['user'] = user.toJson();
    return data;
  }

  Player copyWith({
    CapsMode? mode,
    int? elo,
    SimpleUser? user,
  }) =>
      Player(
        user: user ?? this.user,
        mode: mode ?? this.mode,
        elo: elo ?? this.elo,
      );

  Player.empty() {
    mode = CapsMode.single;
    elo = 0;
    user = SimpleUser.empty();
  }

  @override
  String toString() {
    return "Player {mode: $mode, elo: $elo, user: $user}";
  }
}
