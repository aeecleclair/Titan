import 'package:myecl/generated/openapi.swagger.dart';

String getName(CoreUserSimple user) {
  if (user.nickname != null && user.nickname!.isNotEmpty) {
    return "${user.nickname} (${user.firstname} ${user.name})";
  }
  return "${user.firstname} ${user.name}";
}