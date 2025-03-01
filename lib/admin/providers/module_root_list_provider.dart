import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_provider.dart';

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
  final userProvider = ref.watch(asyncUserProvider);
  ModuleListNotifier notifier =
      ModuleListNotifier(moduleListRepository: moduleListRepository);
  userProvider.maybeWhen(
    data: (data) => tokenExpireWrapperAuth(ref, () async {
      await notifier.loadMyModuleRoots();
    }),
    orElse: () {},
  );
  return notifier;
});
