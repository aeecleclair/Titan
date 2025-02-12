import 'package:myecl/CMM/class/cmm_score.dart';
import 'package:myecl/CMM/class/utils.dart';
import 'package:myecl/tools/repository/repository.dart';

class CMMScoreRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cmm/leaderboard";

  Future<List<CMMScore>> getLeaderboard(Period p) async {
    return List<CMMScore>.from(
      (await getList(suffix: "?period=${periodToRequest(p)}"))
          .map((e) => CMMScore.fromJson(e))
          .toList(),
    );
  }
}
