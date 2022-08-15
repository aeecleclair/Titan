import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/class/user.dart';

class UserRepository extends Repository {
  @override
  final ext = "users/";

  Future<List<SimpleUser>> getAllUsers() async {
    return List<SimpleUser>.from(
        (await getList()).map((x) => SimpleUser.fromJson(x)));
  }

  Future<User> getUser(String userId) async {
    return User.fromJson(await getOne(userId));
  }

  Future<User> getMe() async {
    return User.fromJson(await getOne("me"));
  }

  Future<bool> deleteUser(String userId) async {
    return await delete(userId);
  }

  Future<bool> updateUser(User user) async {
    return await update(user, user.id);
  }

  Future<bool> updateMe(User user) async {
    return await update(user, "me");
  }

  Future<User> createUser(User user) async {
    return User.fromJson(await create(user));
  }
}
