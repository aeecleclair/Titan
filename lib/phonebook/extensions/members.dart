import 'package:myecl/generated/openapi.models.swagger.dart';

extension MemberCompleteName on MemberComplete {
  String getName() {
    if (nickname == null) {
      return '$nickname ($firstname $name)';
    }
    return '$firstname $name';
  }
}
