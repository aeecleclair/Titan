import 'package:myecl/phonebook/class/role.dart';
import 'package:myecl/tools/repository/repository.dart';

class RoleRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/role/";

  Future<List<Role>> getRoleList([String? filter]) async {
    String suffix = "";
    if (filter != null) {
      suffix = "?filter=$filter";
    }
    return List<Role>.from(
        (await getList(suffix: suffix)).map((x) => Role.fromJSON(x)));
  }

  Future<Role> getRole(String roleId) async {
    return Role.fromJSON(await getOne(roleId));
  }

  Future<bool> deleteRole(String roleId) async {
    return await delete(roleId);
  }

  Future<bool> updateRole(Role role) async {
    return await update(role.toJSON(), role.id);
  }

Future<Role> createRole(Role role) async {
    return Role.fromJSON(await create(role.toJSON()));
  }
}
