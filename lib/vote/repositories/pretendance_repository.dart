import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/vote/class/pretendance.dart';

class PretendanceRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "campaign/lists";

  Future<bool> deletePretendance(String pretendanceId) async {
    return await delete("/$pretendanceId");
  }

  Future<bool> updatePretendance(Pretendance pretendance) async {
    return await update(pretendance.toJson(), "/${pretendance.id}");
  }

  Future<Pretendance> createPretendance(Pretendance pretendance) async {
    return Pretendance.fromJson(await create(pretendance.toJson()));
  }

  Future<List<Pretendance>> getPretendances() async {
    final resp = (await getList());
    for (final r in resp) {
      print(r);
      final f = Pretendance.fromJson(r);
      print(f);
    }
    return (await getList()).map((e) => Pretendance.fromJson(e)).toList()
      ..shuffle();
  }
}
