import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/user/providers/user_provider.dart';

class ModuleListNotifier extends ListNotifierAPI<String> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<String>> build() {
    final userProvider = ref.watch(asyncUserProvider);
    userProvider.maybeWhen(
      data: (data) => {loadMyModuleRoots()},
      orElse: () {},
    );
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<String>>> loadMyModuleRoots() async {
    state = const AsyncValue.data(<String>[]);
    return state;
  }
}

final moduleRootListProvider =
    NotifierProvider<ModuleListNotifier, AsyncValue<List<String>>>(
      ModuleListNotifier.new,
    );
