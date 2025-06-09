import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/tools/repository/repository.dart';
import 'package:myemapp/version/class/version.dart';

class VersionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "information";

  Future<Version> getVersion() async {
    initLogger();
    return Version.fromJson(await getOne(""));
  }
}

final versionRepositoryProvider = Provider((ref) {
  return VersionRepository();
});
