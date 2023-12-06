import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ModuleVisibilityListNotifier extends ListNotifier2<ModuleVisibility> {
  final Openapi moduleVisibilityRepository;
  ModuleVisibilityListNotifier({required this.moduleVisibilityRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<ModuleVisibility>>> loadModuleVisibility() async {
    return await loadList(moduleVisibilityRepository.moduleVisibilityGet);
  }

  Future<bool> addGroupToModule(
      ModuleVisibility moduleVisibility, String allowedGroupId) async {
    return await update(
        (moduleVisibility) async =>
            moduleVisibilityRepository.moduleVisibilityPost(
              body: ModuleVisibilityCreate(
                root: moduleVisibility.root,
                allowedGroupId: allowedGroupId,
              ),
            ),
        (list, moduleVisibility) => list
          ..[list.indexWhere((m) => m.root == moduleVisibility.root)] =
              moduleVisibility,
        moduleVisibility);
  }

  Future<bool> deleteGroupAccessForModule(
      ModuleVisibility moduleVisibility, String allowedGroupId) async {
    return await update(
        (moduleVisibility) async =>
            moduleVisibilityRepository.moduleVisibilityRootGroupIdDelete(
              root: moduleVisibility.root,
              groupId: allowedGroupId,
            ),
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
  final moduleVisibilityRepository = ref.watch(repositoryProvider);
  ModuleVisibilityListNotifier notifier = ModuleVisibilityListNotifier(
      moduleVisibilityRepository: moduleVisibilityRepository);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadModuleVisibility();
  });
  return notifier;
});
