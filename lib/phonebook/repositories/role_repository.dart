import 'package:myecl/phonebook/class/role.dart';
import 'package:myecl/phonebook/tools/fake_class.dart';
import 'package:myecl/tools/repository/repository.dart';

class RoleRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/role/";

  Future<List<Role>> getRoleList() async {
    return fakeRoles;
    // return List<Role>.from(
    //     (await getList()).map((x) => Role.fromJSON(x)));
  }

  Future<Role> getRole(String roleId) async {
    return fakeRoles.firstWhere((element) => element.id == roleId);
    //return Role.fromJSON(await getOne(roleId));
  }

  Future<bool> deleteRole(String roleId) async {
    fakeRoles.removeWhere((element) => element.id == roleId);
    return true;
    //return await delete(roleId);
  }

  Future<bool> updateRole(Role role) async {
    fakeRoles[fakeRoles.indexWhere((element) => element.id == role.id)] = role;
    return true;
    //return await update(role.toJSON(), role.id);
  }

Future<Role> createRole(Role role) async {
    fakeRoles.add(role);
    role.id = fakeRoles.length.toString();
    return role;
    //return Role.fromJSON(await create(role.toJSON()));
  }
}
