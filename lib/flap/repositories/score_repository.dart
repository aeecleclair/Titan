import 'package:myecl/flap/class/score.dart';
import 'package:myecl/tools/repository/repository.dart';

class ScoreRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "flappybird/";

  Future<List<Score>> getLeaderboard() async {
    return List<Score>.from(
      (await getList(suffix: "scores")).map((e) => Score.fromJson(e)),
    );
  }

  Future<List<Score>> getHistory() async {
    return List<Score>.from(
      (await getList(suffix: "scores/me")).map((e) => Score.fromJson(e)),
    );
  }

  Future<Score> createScore(Score score) async {
    return Score.fromJson(await create(score.toJson(), suffix: "scores/me"));
  }

  Future<Score> getLeaderBoardPosition() async {
    final response = await getOne("scores/me");
    if (response == null) {
      return Score.empty();
    }
    return Score.fromJson(response);
  }
}
