import 'package:titan/rplace/class/gridInfo.dart';
import 'package:titan/tools/repository/repository.dart';

class GridRepository extends Repository {
  @override
  final ext = "rplace/";

  Future<GridInfo> getGridInformation() async {
    return GridInfo.fromJson(await getOne("information"));
  }
}
