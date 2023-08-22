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

  Future<bool> addGroupToModule(
      ModuleVisibility moduleVisibility, String allowedGroupId) async {
    return await update(
        (moduleVisibility) async =>
            repository.addGroupToModule(moduleVisibility.root, allowedGroupId),
        (list, moduleVisibility) => list
          ..[list.indexWhere((m) => m.root == moduleVisibility.root)] =
              moduleVisibility,
        moduleVisibility);
  }

  Future<bool> deleteGroupAccessForModule(
      ModuleVisibility moduleVisibility, String allowedGroupId) async {
    return await update(
        (moduleVisibility) async => repository.deleteGroupAccessForModule(
            moduleVisibility.root, allowedGroupId),
        (list, moduleVisibility) => list
          ..[list.indexWhere((m) => m.root == moduleVisibility.root)] =
              moduleVisibility,
        moduleVisibility);
  }

  void setState(List<ModuleVisibility> modules) {
    state = AsyncValue.data(modules);
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
