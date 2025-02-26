import 'package:myecl/rplace/class/gridInfo.dart';
import 'package:myecl/tools/repository/repository.dart';

class gridRepository extends Repository {
  @override
  final ext = "rplace/";

  Future<gridInfo> getGridInformation() async {
    return gridInfo.fromJson(await getOne("information"));
  }
}
