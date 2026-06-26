import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/super_admin/providers/permission_name_list_provider.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class PermissionsNotifier extends ListNotifierAPI<CorePermission> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<CorePermission>> build() {
    loadPermissions();
    return const AsyncLoading();
  }

  Future<AsyncValue<List<CorePermission>>> loadPermissions() async {
    return await loadList(repository.permissionsGet);
  }
}

final permissionsProvider =
    NotifierProvider<PermissionsNotifier, AsyncValue<List<CorePermission>>>(
      PermissionsNotifier.new,
    );

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
        final parts = permissionName.split('.');
        final moduleName = parts.first;
        (modulesPermissions[moduleName] ??= []).add(
          parts.length > 1 ? parts[1] : permissionName,
        );
      }
      return modulesPermissions;
    },
    orElse: () => {},
  );
});
