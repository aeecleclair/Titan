import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/module_visibility.dart';
import 'package:myecl/admin/repositories/module_visibility_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ModuleVisibilityListNotifier extends ListNotifier<ModuleVisibility> {
  ModuleVisibilityRepository repository = ModuleVisibilityRepository();
  ModuleVisibilityListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<ModuleVisibility>>> loadModuleVisibility() async {
    return await loadList(repository.getModuleVisibilityList);
  }

// TODO : Update List with API calls
  Future<bool> addGroupToModule(String root, String allowedGroupId) async {
    final isAdded = await repository.addGroupToModule(root, allowedGroupId);
    return isAdded;
  }

  Future<bool> deleteGroupAccessForModule(
      String root, String allowedGroupId) async {
    final isDeleted =
        await repository.deleteGroupAccessForModule(root, allowedGroupId);
    return isDeleted;
  }
}

final moduleVisibilityListProvider = StateNotifierProvider<
    ModuleVisibilityListNotifier, AsyncValue<List<ModuleVisibility>>>((ref) {
  final token = ref.watch(tokenProvider);
  ModuleVisibilityListNotifier notifier =
      ModuleVisibilityListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadModuleVisibility();
  });
  return notifier;
});
