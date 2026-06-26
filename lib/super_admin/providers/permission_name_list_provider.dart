import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class PermissionsNamesListNotifier extends ListNotifierAPI<String> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<String>> build() {
    loadPermissionsNamesList();
    return const AsyncLoading();
  }

  Future<AsyncValue<List<String>>> loadPermissionsNamesList() async {
    return await loadList(repository.permissionsListGet);
  }
}

final permissionsNamesListProvider =
    NotifierProvider<PermissionsNamesListNotifier, AsyncValue<List<String>>>(
      PermissionsNamesListNotifier.new,
    );
