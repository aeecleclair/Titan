import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class ModuleListNotifier extends ListNotifierAPI<String> {
  final Openapi moduleListRepository;
  ModuleListNotifier({required this.moduleListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<String>>> loadMyModuleRoots() async {
    return await loadList(moduleListRepository.moduleVisibilityMeGet);
  }
}

final moduleRootListProvider =
    StateNotifierProvider<ModuleListNotifier, AsyncValue<List<String>>>((ref) {
  final moduleListRepository = ref.watch(repositoryProvider);
  return ModuleListNotifier(moduleListRepository: moduleListRepository)
    ..loadMyModuleRoots();
});
