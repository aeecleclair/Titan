import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/version/class/version.dart';

class VersionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "information";

  Future<Version> getVersion() async {
    host = dotenv.env[kDebugMode ? "DEBUG_HOST" : "RELEASE_HOST"]!;
    initLogger(host);
    return Version.fromJson(await getOne(""));
  }
}
