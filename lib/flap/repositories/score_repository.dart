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

  Future<Score> createScore(Score score) async {
    return Score.fromJson(await create(score.toJson(), suffix: "scores"));
  }

  Future<Score> getLeaderBoardPosition() async {
    final response = await getOne("leaderboard/me");
    if (response == null) {
      return Score.empty();
    }
    return Score.fromJson(response);
  }
}
