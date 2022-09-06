import 'package:myecl/login/class/account_type.dart';
import 'package:myecl/tools/repository/repository.dart';

class SignUpRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "users/";

  Future<bool> createUser(String email, String password, AccountType accountType) async {
    return await create({"email": email, "password": password, "account_type": accountType.toString().split('.')[1]}, suffix: "create");
  }

  Future<bool> recoverUser(String email) async {
    return await create({"email": email}, suffix: "recover");
  }
}