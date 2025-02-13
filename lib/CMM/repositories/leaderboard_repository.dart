import 'package:myecl/CMM/class/cmm_score.dart';
import 'package:myecl/CMM/class/utils.dart';
import 'package:myecl/tools/repository/repository.dart';

class CMMScoreRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cmm/leaderboard";

  Future<List<CMMScoreUser>> getUserLeaderboard(Period p) async {
    return List<CMMScoreUser>.from(
      (await getList(
        suffix:
            "?period=${periodToRequest(p)}&entity=${entityToRequest(Entity.user)}",
      ))
          .map((e) => CMMScoreUser.fromJson(e))
          .toList(),
    );
  }

  Future<List<CMMScorePromo>> getPromoLeaderboard(Period p) async {
    return List<CMMScorePromo>.from(
      (await getList(
        suffix:
            "?period=${periodToRequest(p)}&entity=${entityToRequest(Entity.promo)}",
      ))
          .map((e) => CMMScorePromo.fromJson(e))
          .toList(),
    );
  }

  Future<List<CMMScoreFloor>> getFloorLeaderboard(Period p) async {
    return List<CMMScoreFloor>.from(
      (await getList(
        suffix:
            "?period=${periodToRequest(p)}&entity=${entityToRequest(Entity.floor)}",
      ))
          .map((e) => CMMScoreFloor.fromJson(e))
          .toList(),
    );
  }
}
