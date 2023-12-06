import 'package:myecl/elocaps/class/player.dart';
import 'package:myecl/tools/repository/repository.dart';

class LeaderBoardRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "elocaps/leaderboard";

   Future<List<Player>> getLeaderBoard(String mode) async {
    return List<Player>.from((await getList(suffix:"?mode=$mode")).map((x) => Player.fromJson(x)));
  }
}
