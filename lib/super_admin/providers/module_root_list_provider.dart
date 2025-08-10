import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/super_admin/repositories/module_visibility_repository.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/user/providers/user_provider.dart';

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
      final userProvider = ref.watch(asyncUserProvider);
      ModuleListNotifier notifier = ModuleListNotifier(token: token);
      userProvider.maybeWhen(
        data: (data) => tokenExpireWrapperAuth(ref, () async {
          await notifier.loadMyModuleRoots();
        }),
        orElse: () {},
      );
      return notifier;
    });
