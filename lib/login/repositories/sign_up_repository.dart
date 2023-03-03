import 'package:myecl/login/class/account_type.dart';
import 'package:myecl/login/class/create_account.dart';
import 'package:myecl/login/class/recover_request.dart';
import 'package:myecl/login/tools/functions.dart';
import 'package:myecl/tools/repository/repository.dart';

class SignUpRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "users/";

  Future<bool> createUser(String email, AccountType accountType) async {
    try {
      final value = await create({
        "email": email,
        "account_type": accountTypeToID(accountType),
      }, suffix: "create");
      return value["success"];
    } catch (e) {
      return false;
    }
  }

  Future<bool> recoverUser(String email) async {
    return (await create({"email": email}, suffix: "recover"))["success"];
  }

  Future<bool> resetPasswordUser(String token, String password) async {
    return await create({"reset_token": token, "new_password": password},
        suffix: "reset-password");
  }

  Future<bool> changePasswordUser(
      String userId, String oldPassword, String newPassword) async {
    return await create({
      "user_id": userId,
      "old_password": oldPassword,
      "new_password": newPassword
    }, suffix: "change-password");
  }

  Future<bool> activateUser(CreateAccount createAccount) async {
    try {
      final value = await create(createAccount.toJson(), suffix: "activate");
      return value["success"];
    } catch (e) {
      return false;
    }
  }

  Future<bool> resetPassword(RecoverRequest recoverRequest) async {
    try {
      final value =
          await create(recoverRequest.toJson(), suffix: "reset-password");
      return value["success"];
    } catch (e) {
      return false;
    }
  }
}
