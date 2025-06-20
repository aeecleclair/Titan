import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/repositories/module_visibility_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/user/providers/user_provider.dart';

class ModuleListNotifier extends ListNotifier<String> {
  ModuleVisibilityRepository repository;
  ModuleListNotifier({required this.repository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<String>>> loadMyModuleRoots() async {
    return await loadList(repository.getAccessibleModule);
  }
}

final moduleRootListProvider =
    StateNotifierProvider<ModuleListNotifier, AsyncValue<List<String>>>((ref) {
      final repository = ref.watch(moduleVisibilityRepositoryProvider);
      final userProvider = ref.watch(asyncUserProvider);
      ModuleListNotifier notifier = ModuleListNotifier(repository: repository);
      userProvider.maybeWhen(
        data: (data) => notifier.loadMyModuleRoots(),
        orElse: () {},
      );
      return notifier;
    });
