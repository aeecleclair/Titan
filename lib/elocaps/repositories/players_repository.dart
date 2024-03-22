import 'package:myecl/elocaps/class/game.dart';
import 'package:myecl/elocaps/class/player.dart';
import 'package:myecl/tools/repository/repository.dart';

class PlayersRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "elocaps/players/";

  Future<List<Game>> getGamesList(String userId) async {
    return List<Game>.from(
        (await getList(suffix: "$userId/games")).map((x) => Game.fromJson(x)));
  }

  Future<List<Player>> getPlayerInfo(String userId) async {
    return List<Player>.from(
        (await getList(suffix: userId)).map((x) => Player.fromJson(x)));
  }
}
