import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/user/class/user.dart';

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
    final body = user.toJson();
    final nullTrimmedBody = <String, dynamic>{};
    body.forEach((key, value) {
      if (value != null) {
        nullTrimmedBody[key] = value;
      }
    });
    return await update(nullTrimmedBody, user.id);
  }

  Future<bool> updateMe(User user) async {
    final body = user.toJson();
    final nullTrimmedBody = <String, dynamic>{};
    body.forEach((key, value) {
      if (value != null) {
        nullTrimmedBody[key] = value;
      }
    });
    return await update(nullTrimmedBody, "me");
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

final userRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return UserRepository()..setToken(token);
});
