import 'package:titan/rplace/class/gridInfo.dart';
import 'package:titan/tools/repository/repository.dart';

class GridRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "rplace/";

  Future<GridInfo> getGridInformation() async {
    return GridInfo.fromJson(await getOne("information"));
  }
}
