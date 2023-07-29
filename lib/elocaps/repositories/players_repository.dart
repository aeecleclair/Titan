import 'package:myecl/elocaps/class/game.dart';
import 'package:myecl/elocaps/class/player.dart';
import 'package:myecl/tools/repository/repository.dart';

class PlayersRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "elocaps/players";


   Future<List<Game>> getGamesList(String userId) async {
    return List<Game>.from((await getList(suffix: "/$userId/games")).map((x) => Game.fromJson(x)));
  }

  Future<Player> getPlayerInfo(String userId) async {
    return Player.fromJson(await getOne(userId));
  }
  
  }