import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/repositories/permission_repository.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class PermissionsNamesListNotifier extends ListNotifier<String> {
  PermissionRepository repository = PermissionRepository();
  PermissionsNamesListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<String>>> loadPermissionsNamesList() async {
    return await loadList(repository.getPermissionsNamesList);
  }
}

final permissionsNamesListProvider =
    StateNotifierProvider<
      PermissionsNamesListNotifier,
      AsyncValue<List<String>>
    >((ref) {
      final token = ref.watch(tokenProvider);
      PermissionsNamesListNotifier notifier = PermissionsNamesListNotifier(
        token: token,
      );
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadPermissionsNamesList();
      });
      return notifier;
    });
