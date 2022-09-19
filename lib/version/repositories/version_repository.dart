import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/version/class/version.dart';

class VersionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "version/";

  Future<Version> getVersion() async {
    return Version.fromJson(await getOne());
  }
}