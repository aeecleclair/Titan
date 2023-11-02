import 'package:myecl/user/class/list_users.dart';

String getAvatarName(SimpleUser user) {
  final name = user.nickname != null
      ? user.nickname!.substring(0, user.nickname!.length > 3 ? 3 : user.nickname!.length)
      : user.firstname.substring(0, user.firstname.length > 3 ? 3 : user.firstname.length);
  return name;
}