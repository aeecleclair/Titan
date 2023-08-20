import 'package:myecl/admin/class/module_visibility.dart';
import 'package:myecl/tools/repository/repository.dart';

class ModuleVisibilitiesRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "module_visibility/";

  Future<List<ModuleVisibilities>> getModuleVisibilitiesList() async {
    return List<ModuleVisibilities>.from(
        (await getList()).map((x) => ModuleVisibilities.fromJson(x)));
  }

  Future<List<String>> getAccessibleModule() async {
    return List<String>.from(await getList(suffix: "me"));
  }

  Future<bool> addGroupToModule(ModuleVisibility moduleVisibility) async {
    await create(moduleVisibility.toJson());
    return true;
  }

  Future<bool> deleteGroupAccessForModule(
      ModuleVisibility moduleVisibility) async {
    return await delete(
        "${moduleVisibility.root}/${moduleVisibility.allowedGroupId}");
  }
}
