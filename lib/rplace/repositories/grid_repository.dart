import 'package:titan/rplace/class/gridInfo.dart';
import 'package:titan/tools/repository/repository.dart';

class gridRepository extends Repository {
  @override
  final ext = "rplace/";

  Future<gridInfo> getGridInformation() async {
    return gridInfo.fromJson(await getOne("information"));
  }
}
