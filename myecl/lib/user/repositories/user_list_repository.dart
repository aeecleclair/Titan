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

  Future<List<SimpleUser>> searchUser(String query) async {
    return List<SimpleUser>.from(
        (await getList(suffix: "search?query=" + query))
            .map((x) => SimpleUser.fromJson(x)));
  }
}
