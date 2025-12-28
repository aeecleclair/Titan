import 'package:titan/admin/class/permissions.dart';
import 'package:titan/tools/repository/repository.dart';

class PermissionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "permissions/";

  Future<List<CorePermission>> getAllPermissions() async {
    return List<CorePermission>.from(
      (await getList()).map((e) => CorePermission.fromJson(e)),
    );
  }

  Future<List<String>> getPermissionsNamesList() async {
    return List<String>.from(await getList(suffix: "list"));
  }

  Future<bool> addGroupPermission(GroupPermission groupPermission) async {
    await create(groupPermission.toJson());
    return true;
  }

  Future<bool> addAccountTypePermission(
    AccountTypePermission accountTypePermission,
  ) async {
    await create(accountTypePermission.toJson());
    return true;
  }

  Future<bool> deleteGroupPermission(GroupPermission groupPermission) async {
    return await delete("", body: groupPermission.toJson());
  }

  Future<bool> deleteAccountTypePermission(
    AccountTypePermission accountTypePermission,
  ) async {
    return await delete("", body: accountTypePermission.toJson());
  }
}
