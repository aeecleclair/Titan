import 'package:myecl/meme/class/meme_score.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/tools/repository/repository.dart';

class MemeScoreRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "meme/leaderboard";

  Future<List<MemeScoreUser>> getUserLeaderboard(Period p) async {
    return List<MemeScoreUser>.from(
      (await getList(
        suffix:
            "?period=${p.name.split(".").last}&entity=${Entity.user.name.split(".").last}",
      ))
          .map((e) => MemeScoreUser.fromJson(e))
          .toList(),
    );
  }

  Future<List<MemeScorePromo>> getPromoLeaderboard(Period p) async {
    return List<MemeScorePromo>.from(
      (await getList(
        suffix:
            "?period=${p.name.split(".").last}&entity=${Entity.user.name.split(".").last}",
      ))
          .map((e) => MemeScorePromo.fromJson(e))
          .toList(),
    );
  }

  Future<List<MemeScoreFloor>> getFloorLeaderboard(Period p) async {
    return List<MemeScoreFloor>.from(
      (await getList(
        suffix:
            "?period=${p.name.split(".").last}&entity=${Entity.user.name.split(".").last}",
      ))
          .map((e) => MemeScoreFloor.fromJson(e))
          .toList(),
    );
  }

  Future<MemeScore> getMyScore(Period p) async {
    final response = await getOne("/me?period=${p.name.split(".").last}");
    if (response == null) {
      return MemeScore.empty();
    }
    return MemeScore.fromJson(response);
  }
}
