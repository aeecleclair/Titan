import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/module_visibility.dart';
import 'package:myecl/admin/repositories/module_visibility_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ModuleVisibilitiesListNotifier extends ListNotifier<ModuleVisibilities> {
  ModuleVisibilitiesRepository repository = ModuleVisibilitiesRepository();
  ModuleVisibilitiesListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<ModuleVisibilities>>> loadModuleVisibilities() async {
    return await loadList(repository.getModuleVisibilitiesList);
  }

// TODO : Update List with API calls
  Future<bool> addGroupToModule(ModuleVisibility moduleVisibility) async {
    final isAdded = await repository.addGroupToModule(moduleVisibility);
    return isAdded;
  }

  Future<bool> deleteGroupAccessForModule(
      ModuleVisibility moduleVisibility) async {
    final isDeleted =
        await repository.deleteGroupAccessForModule(moduleVisibility);
    return isDeleted;
  }
}

final moduleVisibilitiesListProvider = StateNotifierProvider<
    ModuleVisibilitiesListNotifier,
    AsyncValue<List<ModuleVisibilities>>>((ref) {
  final token = ref.watch(tokenProvider);
  ModuleVisibilitiesListNotifier notifier =
      ModuleVisibilitiesListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadModuleVisibilities();
  });
  return notifier;
});

class ModuleListNotifier extends ListNotifier<String> {
  ModuleVisibilitiesRepository repository = ModuleVisibilitiesRepository();
  ModuleListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<String>>> loadMyModuleRoots() async {
    return await loadList(repository.getAccessibleModule);
  }
}

final moduleListProvider =
    StateNotifierProvider<ModuleListNotifier, AsyncValue<List<String>>>((ref) {
  final token = ref.watch(tokenProvider);
  ModuleListNotifier notifier = ModuleListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadMyModuleRoots();
  });
  return notifier;
});
