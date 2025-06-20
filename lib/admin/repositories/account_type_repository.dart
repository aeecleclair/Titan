import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/account_type.dart';
import 'package:myecl/tools/repository/repository.dart';

class AccountTypeRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "users/account-types/";

  AccountTypeRepository(super.ref);

  Future<List<AccountType>> getAccountTypeList() async {
    return List<AccountType>.from(
      (await getList()).map((x) => AccountType.fromJson(x)),
    );
  }
}

final accountTypeRepositoryProvider = Provider((ref) {
  return AccountTypeRepository(ref);
});
