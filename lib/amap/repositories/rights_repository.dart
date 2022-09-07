import 'package:myecl/amap/class/rights.dart';
import 'package:myecl/tools/repository/repository.dart';

class RightRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/";

  Future<Right> getRights() async {
    return Right.fromJson(await getOne("rights"));
  }
}