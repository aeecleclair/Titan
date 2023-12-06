import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/client_index.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_provider.dart';

class ModuleListNotifier extends ListNotifier2<String> {
  final Openapi moduleRootListRepository;
  ModuleListNotifier({required this.moduleRootListRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<String>>> loadMyModuleRoots() async {
    return await loadList(moduleRootListRepository.moduleVisibilityMeGet);
  }
}

final moduleRootListProvider =
    StateNotifierProvider<ModuleListNotifier, AsyncValue<List<String>>>((ref) {
  final moduleRootListRepository = ref.watch(repositoryProvider);
  final userProvider = ref.watch(asyncUserProvider);
  ModuleListNotifier notifier =
      ModuleListNotifier(moduleRootListRepository: moduleRootListRepository);
  userProvider.maybeWhen(
      data: (data) => tokenExpireWrapperAuth(ref, () async {
            await notifier.loadMyModuleRoots();
          }),
      orElse: () {});
  return notifier;
});
