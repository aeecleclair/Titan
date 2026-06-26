import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class UserManagerListNotifier extends ListNotifierAPI<Manager> {
  Openapi get managerRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<Manager>> build() {
    loadManagers();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Manager>>> loadManagers() async {
    return await loadList(managerRepository.bookingManagersUsersMeGet);
  }
}

final userManagerListProvider =
    NotifierProvider<UserManagerListNotifier, AsyncValue<List<Manager>>>(
      UserManagerListNotifier.new,
    );
