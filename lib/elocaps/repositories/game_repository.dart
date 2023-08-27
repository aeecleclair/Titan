import 'package:myecl/elocaps/class/game.dart';
import 'package:myecl/tools/repository/repository.dart';

class GameRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "elocaps/games";

  Future<List<Game>> getGameList() async {
    return List<Game>.from((await getList()).map((x) => Game.fromJson(x)));
  }

  Future<Game> getGame(String gameId) async {
    return Game.fromJson(await getOne(gameId));
  }

   Future<Game> createGame(Game game) async {
    print(game.toJsonForCreate());
    return Game.fromJson(await create(game.toJsonForCreate()));
  }

   Future<List<Game>> getLatestGame() async {
    return List<Game>.from((await getList(suffix: "/latest")).map((x) => Game.fromJson(x)));
  }
  
  Future<bool> validateGame(String gameId) async {
    return await create({},suffix:"/$gameId/validate");
  }

  }