import 'package:titan/admin/class/module_visibility.dart';
import 'package:titan/tools/repository/repository.dart';

class ModuleVisibilityRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "module-visibility/";

  Future<List<ModuleVisibility>> getModuleVisibilityList() async {
    return List<ModuleVisibility>.from(
      (await getList()).map((x) => ModuleVisibility.fromJson(x)),
    );
  }

  Future<List<String>> getAccessibleModule() async {
    return List<String>.from(await getList(suffix: "me"));
  }

  Future<bool> addGroupToModule(String root, String allowedGroupId) async {
    await create({'root': root, 'allowed_group_id': allowedGroupId});
    return true;
  }

  Future<bool> addAccountTypeToModule(
    String root,
    String allowedAccounTypes,
  ) async {
    await create({'root': root, 'allowed_account_type': allowedAccounTypes});
    return true;
  }

  Future<bool> deleteGroupAccessForModule(
    String root,
    String allowedGroupId,
  ) async {
    return await delete("$root/groups/$allowedGroupId");
  }

  Future<bool> deleteAccountTypeAccessForModule(
    String root,
    String allowedAccounTypes,
  ) async {
    return await delete("$root/account-types/$allowedAccounTypes");
  }
}
