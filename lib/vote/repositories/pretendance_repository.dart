import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/vote/class/pretendance.dart';

class PretendanceRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "campaign/";

  Future<bool> deletePretendance(String pretendanceId) async {
    return await delete("lists/$pretendanceId");
  }

  Future<bool> updatePretendance(Pretendance pretendance) async {
    return await update(pretendance, "lists/${pretendance.id}");
  }

  Future<Pretendance> createPretendance(Pretendance pretendance) async {
    return Pretendance.fromJson(await create(pretendance, suffix: "lists/"));
  }

  Future<List<Pretendance>> getPretendances() async {
    return (await getList(suffix: "lists/"))
        .map((e) => Pretendance.fromJson(e))
        .toList();
  }

  Future<List<Pretendance>> getPretendanceList(String sectionId) async {
    return (await getList(suffix: "sections/$sectionId/list"))
        .map((e) => Pretendance.fromJson(e))
        .toList();
  }
}
