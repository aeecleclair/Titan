import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/admin/adapters/module_visibility.dart';

class ModuleVisibilityListNotifier extends ListNotifierAPI<ModuleVisibility> {
  final Openapi moduleListRepository;
  ModuleVisibilityListNotifier({required this.moduleListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<ModuleVisibility>>> loadModuleVisibility() async {
    return await loadList(moduleListRepository.moduleVisibilityGet);
  }

  Future<bool> addGroupToModule(
    ModuleVisibility moduleVisibility,
    String allowedGroupId,
  ) async {
    return await update(
      () => moduleListRepository.moduleVisibilityPost(
        body: moduleVisibility.toModuleVisibilityCreate(allowedGroupId),
      ),
      (moduleVisibility) => moduleVisibility.root,
      moduleVisibility,
    );
  }

  Future<bool> deleteGroupAccessForModule(
    ModuleVisibility moduleVisibility,
    String allowedGroupId,
  ) async {
    return await update(
      () => moduleListRepository.moduleVisibilityRootGroupsGroupIdDelete(
        root: moduleVisibility.root,
        groupId: allowedGroupId,
      ),
      (moduleVisibility) => moduleVisibility.root,
      moduleVisibility,
    );
  }

  Future<bool> addAccountTypeToModule(
    ModuleVisibility moduleVisibility,
    AccountType allowedAccountType,
  ) async {
    return await update(
      () => moduleListRepository.moduleVisibilityPost(
        body: moduleVisibility
            .toModuleVisibilityCreate(allowedAccountType.toString()),
      ),
      (moduleVisibility) => moduleVisibility.root,
      moduleVisibility,
    );
  }

  Future<bool> deleteAccountTypeAccessForModule(
    ModuleVisibility moduleVisibility,
    AccountType allowedAccountType,
  ) async {
    return await update(
      () => moduleListRepository
          .moduleVisibilityRootAccountTypesAccountTypeDelete(
        root: moduleVisibility.root,
        accountType: allowedAccountType,
      ),
      (moduleVisibility) => moduleVisibility.root,
      moduleVisibility,
    );
  }

  void setState(List<ModuleVisibility> modules) {
    state = AsyncValue.data(modules);
  }
}

final moduleVisibilityListProvider = StateNotifierProvider<
    ModuleVisibilityListNotifier, AsyncValue<List<ModuleVisibility>>>((ref) {
  final moduleListRepository = ref.watch(repositoryProvider);
  ModuleVisibilityListNotifier notifier =
      ModuleVisibilityListNotifier(moduleListRepository: moduleListRepository);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadModuleVisibility();
  });
  return notifier;
});
