import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/role.dart';
import 'package:myecl/phonebook/repositories/role_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class RoleListNotifier extends ListNotifier<Role> {
  final RoleRepository roleRepository = RoleRepository();
  RoleListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    roleRepository.setToken(token);
  }

  late List<Role> roleList;

  Future<AsyncValue<List<Role>>> loadRoles() async {
    roleList = await roleRepository.getRoleList();
    return await loadList(() async => roleRepository.getRoleList());
  }

  List<Role> filterRoles(String filter) {
    return roleList
        .where((role) =>
            role.name.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }

//  Future<AsyncValue<List<Role>>> loadRolesFromUser(User user) async {
//    return await loadList(() async {
//      return user.roles;
//    });
//  }

  Future<bool> createRole(Role role) async {
    return await add(roleRepository.createRole, role);
  }

  Future<bool> updateRole(Role role) async {
    return await update(
        roleRepository.updateRole,
        (roles, role) =>
            roles..[roles.indexWhere((g) => g.id == role.id)] = role,
        role);
  }

  Future<bool> deleteRole(Role role) async {
    return await delete(
        roleRepository.deleteRole,
        (roles, role) => roles..removeWhere((i) => i.id == role.id),
        role.id,
        role);
  }

  void setRole(Role role) {
    state.whenData(
      (d) {
        state =
            AsyncValue.data(d..[d.indexWhere((g) => g.id == role.id)] = role);
      },
    );
  }
}

final roleListProvider =
    StateNotifierProvider<RoleListNotifier, AsyncValue<List<Role>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  RoleListNotifier provider = RoleListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadRoles();
  });
  return provider;
});
