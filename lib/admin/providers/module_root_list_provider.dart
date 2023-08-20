import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/repositories/module_visibility_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ModuleListNotifier extends ListNotifier<String> {
  ModuleVisibilityRepository repository = ModuleVisibilityRepository();
  ModuleListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<String>>> loadMyModuleRoots() async {
    return await loadList(repository.getAccessibleModule);
  }
}

final moduleRootListProvider =
    StateNotifierProvider<ModuleListNotifier, AsyncValue<List<String>>>((ref) {
  final token = ref.watch(tokenProvider);
  ModuleListNotifier notifier = ModuleListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadMyModuleRoots();
  });
  return notifier;
});
