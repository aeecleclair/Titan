import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/version/class/version.dart';

class VersionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "information";

  VersionRepository(super.ref);

  Future<Version> getVersion() async {
    initLogger();
    return Version.fromJson(await noAuthGetOne(""));
  }
}
