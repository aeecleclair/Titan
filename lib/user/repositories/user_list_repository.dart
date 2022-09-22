import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/list_users.dart';

class UserListRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "users/";

  Future<List<SimpleUser>> getAllUsers() async {
    return List<SimpleUser>.from(
        (await getList()).map((x) => SimpleUser.fromJson(x)));
  }

  Future<List<SimpleUser>> searchUser(String query, {List<String>? includeId, List<String>? excludeId}) async {
    String suffix = "search?query=$query";
    if (includeId != null) {
      for (final id in includeId) {
        suffix += "&includedGroups=$id";
      }
    }
    if (excludeId != null) {
      for (final id in excludeId) {
        suffix += "&excludedGroups=$id";
      }
    }
    return List<SimpleUser>.from(
        (await getList(suffix: suffix))
            .map((x) => SimpleUser.fromJson(x)));
  }
}
