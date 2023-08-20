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
    print('load');
    return await loadList(repository.getModuleVisibilitiesList);
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
