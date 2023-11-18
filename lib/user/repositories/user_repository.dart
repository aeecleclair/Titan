import 'package:chopper/chopper.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/repository/repository2.dart';

class UserRepository extends Repository {
  UserRepository({required String token}) : super(token: token);

  Future<Response<CoreUser>> getUser(String userId) =>
      repository.usersUserIdGet(userId: userId);

  Future<Response<CoreUser>> getMe() => repository.usersMeGet();

  Future<Response<AppUtilsTypesStandardResponsesResult>> createUser(
          CoreUserCreateRequest user) =>
      repository.usersCreatePost(body: user);

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

  Future<Response<dynamic>> updateMe(CoreUserUpdate user) =>
      repository.usersMePatch(body: user);

  Future<bool> changePassword(
    String oldPassword,
    String newPassword,
    String mail,
  ) async {
    try {
      return (await create(
        {
          "old_password": oldPassword,
          "new_password": newPassword,
          "email": mail,
        },
        suffix: "change-password",
      ))["success"];
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

final userRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return UserRepository()..setToken(token);
});
