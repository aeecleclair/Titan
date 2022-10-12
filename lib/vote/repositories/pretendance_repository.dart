import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/vote/class/pretendance.dart';

class PretendanceRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "/campaign/lists/";

  Future<bool> deletePretendance(String pretendanceId) async {
    return await delete(pretendanceId);
  }

  Future<bool> updatePretendance(Pretendance pretendance) async {
    return await update(pretendance, pretendance.id);
  }

  Future<Pretendance> createPretendance(Pretendance pretendance) async {
    return Pretendance.fromJson(await create(pretendance));
  }

  Future<List<Pretendance>> getPretendances() async {
    return (await getList()).map((e) => Pretendance.fromJson(e)).toList();
  }
}
