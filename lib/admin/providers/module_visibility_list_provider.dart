import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ModuleVisibilityListNotifier extends ListNotifier2<ModuleVisibility> {
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
        body: ModuleVisibilityCreate(
          root: moduleVisibility.root,
          allowedGroupId: allowedGroupId,
        ),
      ),
      (list, moduleVisibility) => list
        ..[list.indexWhere((m) => m.root == moduleVisibility.root)] =
            moduleVisibility,
      moduleVisibility,
    );
  }

  Future<bool> deleteGroupAccessForModule(
    ModuleVisibility moduleVisibility,
    String allowedGroupId,
  ) async {
    return await update(
      () async => moduleListRepository.moduleVisibilityRootGroupsGroupIdDelete(
        root: moduleVisibility.root,
        groupId: allowedGroupId,
      ),
      (list, moduleVisibility) => list
        ..[list.indexWhere((m) => m.root == moduleVisibility.root)] =
            moduleVisibility,
      moduleVisibility,
    );
  }

  //  W8 to merge dedicated PR
  Future<bool> addAccountTypeToModule(
    ModuleVisibility moduleVisibility,
    AccountType allowedAccountType,
  ) async {
    return await update(
      () async => moduleListRepository.addAccountTypeToModule(
        moduleVisibility.root,
        allowedAccountType,
      ),
      (list, moduleVisibility) => list
        ..[list.indexWhere((m) => m.root == moduleVisibility.root)] =
            moduleVisibility,
      moduleVisibility,
    );
  }

  Future<bool> deleteAccountTypeAccessForModule(
    ModuleVisibility moduleVisibility,
    AccountType allowedAccountType,
  ) async {
    return await update(
      () async => moduleListRepository
          .moduleVisibilityRootAccountTypesAccountTypeDelete(
        root: moduleVisibility.root,
        accountType: allowedAccountType,
      ),
      (list, moduleVisibility) => list
        ..[list.indexWhere((m) => m.root == moduleVisibility.root)] =
            moduleVisibility,
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
