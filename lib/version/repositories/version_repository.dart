import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/version/class/version.dart';

class VersionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "information";

  Future<Version> getVersion() async {
    initLogger();
    print("getVersion");
    return Version.fromJson(await getOne(""));
  }
}
