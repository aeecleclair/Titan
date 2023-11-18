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

  Future<Response<dynamic>> updateUser(
          CoreUserUpdateAdmin user, String userId) =>
      repository.usersUserIdPatch(userId: userId, body: user);

  Future<Response<dynamic>> updateMe(CoreUserUpdate user) =>
      repository.usersMePatch(body: user);

  Future<Response<AppUtilsTypesStandardResponsesResult>> changePassword(
          String oldPassword, String newPassword, String mail) =>
      repository.usersChangePasswordPost(
          body: ChangePasswordRequest(
              email: mail, newPassword: newPassword, oldPassword: oldPassword));

  Future<Response<dynamic>> deletePersonalData() =>
      repository.usersMeAskDeletionPost();

  Future<Response<dynamic>> askMailMigration(String mail) =>
      repository.usersMigrateMailPost(body: MailMigrationRequest(newEmail: mail));
}