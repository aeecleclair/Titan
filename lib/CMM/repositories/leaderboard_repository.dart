import 'package:myecl/CMM/class/cmm_score.dart';
import 'package:myecl/admin/class/account_type.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/list_users.dart';

class CMMScoreRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cmm/";

  Future<List<CMMScore>> getLeaderboard() async {
    final user = SimpleUser(
      name: "Ñool",
      firstname: "Ñool",
      nickname: "Ñool",
      id: "A",
      accountType: AccountType(type: "Student"),
    );
    return <CMMScore>[
      CMMScore(value: 5, user: user, position: 1),
      CMMScore(value: 2, user: user, position: 2),
      CMMScore(value: 1, user: user, position: 3),
    ];
    // return List<CMMScore>.from(
    //   (await getList(suffix: "CMMScores"))
    //       .mapIndexed((index, e) => CMMScore.fromJson(e, index: index + 1)),
    // );
  }

  Future<CMMScore> createCMMScore(CMMScore cmmScore) async {
    return CMMScore.fromJson(
      await create(cmmScore.toJson(), suffix: "CMMScores"),
    );
  }

  Future<CMMScore> getLeaderBoardPosition() async {
    final response = await getOne("CMMScores/me");
    if (response == null) {
      return CMMScore.empty();
    }
    return CMMScore.fromJson(response);
  }
}
