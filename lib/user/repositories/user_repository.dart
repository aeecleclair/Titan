import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/user.dart';

class UserRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "users/";

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

  Future<bool> changePassword(
      String oldPassword, String newPassword, String mail) async {
    try {
      return (await create({
        "old_password": oldPassword,
        "new_password": newPassword,
        "email": mail
      }, suffix: "change-password"))["success"];
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePersonalData() async {
    try {
      return await create({}, suffix: "me/ask-deletion");
    } catch (e) {
      return false;
    }
  }

  Future<bool> askMailMigration(String mail) async {
    try {
      return await create({"new_email": mail}, suffix: "migrate-mail");
    } catch (e) {
      return false;
    }
  }
}
