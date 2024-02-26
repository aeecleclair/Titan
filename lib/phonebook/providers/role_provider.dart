import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/phonebook/class/role.dart';
import 'package:myecl/phonebook/repositories/role_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';


class RoleNotifier extends SingleNotifier<Role> {
  final RoleRepository roleRepository = RoleRepository();
    RoleNotifier({required String token})
        : super(const AsyncValue.loading()) {
      roleRepository.setToken(token);
    }

  void setRole(Role i) {
    state = AsyncValue.data(i);
  }

  Future<bool> updateRole(Role role) async {
    return update((role) async => roleRepository.updateRole(role), role);
  }

  Future<bool> deleteRole(Role role) async {
    return delete((role) async => roleRepository.deleteRole(role), role, role.id);
  }

  Future<bool> createRole(Role role) async {
    return add((role) async => roleRepository.createRole(role), role);
  }
}

final roleProvider = StateNotifierProvider<RoleNotifier, AsyncValue<Role>>((ref) {
  final token = ref.watch(tokenProvider);
  return RoleNotifier(token: token);
});