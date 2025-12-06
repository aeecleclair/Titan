import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/permissions.dart';
import 'package:titan/admin/providers/permission_list_provider.dart';
import 'package:titan/admin/repositories/permission_repository.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class PermissionsNotifier extends SingleNotifier<AllPermissions> {
  PermissionRepository repository = PermissionRepository();
  PermissionsNotifier({required String token})
    : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<AllPermissions>> loadPermissions() async {
    return await load(repository.getAllPermissions);
  }

  Future<bool> addGroupPermission(GroupPermission permission) async {
    final permissions = state.value;
    if (permissions == null) return false;
    permissions.groupPermissions.add(permission);
    return await update(
      (_) async => repository.addGroupPermission(permission),
      permissions,
    );
  }

  Future<bool> deleteGroupPermission(GroupPermission groupPermission) async {
    final permissions = state.value;
    if (permissions == null) return false;
    permissions.groupPermissions.removeWhere((p) => p == groupPermission);

    return await update(
      (moduleVisibility) async =>
          repository.deleteGroupPermission(groupPermission),
      permissions,
    );
  }

  Future<bool> addAccountTypePermission(
    AccountTypePermission permission,
  ) async {
    final permissions = state.value;
    if (permissions == null) return false;
    permissions.accountTypePermissions.add(permission);
    return await update(
      (_) async => repository.addAccountTypePermission(permission),
      permissions,
    );
  }

  Future<bool> deleteAccountTypePermission(
    AccountTypePermission accountTypePermission,
  ) async {
    final permissions = state.value;
    if (permissions == null) return false;
    permissions.accountTypePermissions.removeWhere(
      (p) => p == accountTypePermission,
    );

    return await update(
      (moduleVisibility) async =>
          repository.deleteAccountTypePermission(accountTypePermission),
      permissions,
    );
  }
}

final allPermissionsProvider =
    StateNotifierProvider<PermissionsNotifier, AsyncValue<AllPermissions>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      PermissionsNotifier notifier = PermissionsNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadPermissions();
      });
      return notifier;
    });

final permissionsProvider = Provider<Map<String, Permission>>((ref) {
  final allPermissions = ref.watch(allPermissionsProvider);
  final allPermissionsNames = ref.watch(permissionsNamesListProvider);
  return allPermissions.maybeWhen(
    data: (permissions) {
      return allPermissionsNames.maybeWhen(
        data: (names) {
          final permissionsMap = <String, Permission>{};
          for (var name in names) {
            name = name.split(".")[1];
            permissionsMap[name] = Permission(
              permissionName: name,
              authorizedAccountTypes: permissions.accountTypePermissions
                  .where((atp) => atp.permissionName == name)
                  .map((atp) => atp.accountType)
                  .toList(),
              authorizedGroups: permissions.groupPermissions
                  .where((gp) => gp.permissionName == name)
                  .map((gp) => gp.groupId)
                  .toList(),
            );
          }
          return permissionsMap;
        },
        orElse: () => {},
      );
    },
    orElse: () => {},
  );
});

final moduleGroupedPermissionsProvider = Provider<Map<String, List<String>>>((
  ref,
) {
  final permissionsNames = ref.watch(permissionsNamesListProvider);
  return permissionsNames.maybeWhen(
    data: (names) {
      final Map<String, List<String>> modulesPermissions = {};

      for (var permissionName in names) {
        final moduleName = permissionName.split('.').first;
        if (!modulesPermissions.containsKey(moduleName)) {
          modulesPermissions[moduleName] = [permissionName.split('.')[1]];
        } else {
          modulesPermissions[moduleName]!.add(permissionName.split('.')[1]);
        }
      }
      return modulesPermissions;
    },
    orElse: () => {},
  );
});
