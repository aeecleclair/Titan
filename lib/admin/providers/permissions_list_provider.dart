import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/permissions.dart';
import 'package:titan/admin/providers/permission_name_list_provider.dart';
import 'package:titan/admin/repositories/permission_repository.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class PermissionsNotifier extends ListNotifier<CorePermission> {
  PermissionRepository repository = PermissionRepository();
  PermissionsNotifier({required String token})
    : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<CorePermission>>> loadPermissions() async {
    return await loadList(repository.getAllPermissions);
  }

  Future<bool> addGroupPermission(GroupPermission newPermission) async {
    final permission = CorePermission(
      permissionName: newPermission.permissionName,
      authorizedGroupIds: [newPermission.groupId],
      authorizedAccountTypes: [],
    );
    return await update(
      (_) async => repository.addGroupPermission(newPermission),
      (permissions, newPermission) {
        final permission = permissions.firstWhere(
          (p) => p.permissionName == newPermission.permissionName,
          orElse: () => CorePermission.empty(),
        );
        if (permission.permissionName.isEmpty) {
          permission.permissionName = newPermission.permissionName;
          permission.authorizedGroupIds.add(
            newPermission.authorizedGroupIds.first,
          );
          permissions.add(permission);
        } else {
          permission.authorizedGroupIds.add(
            newPermission.authorizedGroupIds.first,
          );
        }
        return permissions;
      },
      permission,
    );
  }

  Future<bool> deleteGroupPermission(GroupPermission groupPermission) async {
    final permissions = CorePermission(
      permissionName: groupPermission.permissionName,
      authorizedGroupIds: [groupPermission.groupId],
      authorizedAccountTypes: [],
    );
    return await update(
      (moduleVisibility) async =>
          repository.deleteGroupPermission(groupPermission),
      (permissions, groupPermission) {
        final permission = permissions.firstWhere(
          (p) => p.permissionName == groupPermission.permissionName,
          orElse: () => CorePermission.empty(),
        );
        if (permission.permissionName.isNotEmpty) {
          permission.authorizedGroupIds.removeWhere(
            (id) => id == groupPermission.authorizedGroupIds.first,
          );
        }
        return permissions;
      },
      permissions,
    );
  }

  Future<bool> addAccountTypePermission(
    AccountTypePermission newPermission,
  ) async {
    final permission = CorePermission(
      permissionName: newPermission.permissionName,
      authorizedGroupIds: [],
      authorizedAccountTypes: [newPermission.accountType],
    );
    return await update(
      (_) async => repository.addAccountTypePermission(newPermission),
      (permissions, permission) {
        final perm = permissions.firstWhere(
          (p) => p.permissionName == permission.permissionName,
          orElse: () => CorePermission.empty(),
        );
        if (perm.permissionName.isEmpty) {
          perm.permissionName = permission.permissionName;
          perm.authorizedAccountTypes.add(
            permission.authorizedAccountTypes.first,
          );
          permissions.add(perm);
        } else {
          perm.authorizedAccountTypes.add(
            permission.authorizedAccountTypes.first,
          );
        }
        return permissions;
      },
      permission,
    );
  }

  Future<bool> deleteAccountTypePermission(
    AccountTypePermission accountTypePermission,
  ) async {
    final permission = CorePermission(
      permissionName: accountTypePermission.permissionName,
      authorizedGroupIds: [],
      authorizedAccountTypes: [accountTypePermission.accountType],
    );

    return await update(
      (moduleVisibility) async =>
          repository.deleteAccountTypePermission(accountTypePermission),
      (permissions, accountTypePermission) {
        final perm = permissions.firstWhere(
          (p) => p.permissionName == accountTypePermission.permissionName,
          orElse: () => CorePermission.empty(),
        );
        if (perm.permissionName.isNotEmpty) {
          perm.authorizedAccountTypes.removeWhere(
            (at) => at == accountTypePermission.authorizedAccountTypes.first,
          );
        }
        return permissions;
      },
      permission,
    );
  }
}

final permissionsProvider =
    StateNotifierProvider<
      PermissionsNotifier,
      AsyncValue<List<CorePermission>>
    >((ref) {
      final token = ref.watch(tokenProvider);
      PermissionsNotifier notifier = PermissionsNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadPermissions();
      });
      return notifier;
    });

final mappedPermissionsProvider = Provider<Map<String, CorePermission>>((ref) {
  final permissionsAsync = ref.watch(permissionsProvider);
  return permissionsAsync.maybeWhen(
    data: (permissions) {
      final Map<String, CorePermission> mappedPermissions = {};
      for (var permission in permissions) {
        mappedPermissions[permission.permissionName] = permission;
      }
      return mappedPermissions;
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
