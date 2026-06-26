import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/booking/adapters/manager.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class ManagerListNotifier extends ListNotifierAPI<Manager> {
  Openapi get managerRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<Manager>> build() {
    loadManagers();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Manager>>> loadManagers() async {
    return await loadList(managerRepository.bookingManagersGet);
  }

  Future<bool> addManager(ManagerBase manager) async {
    return await add(
      () => managerRepository.bookingManagersPost(body: manager),
      manager,
    );
  }

  Future<bool> updateManager(Manager manager) async {
    return await update(
      () => managerRepository.bookingManagersManagerIdPatch(
        managerId: manager.id,
        body: manager.toManagerUpdate(),
      ),
      (manager) => manager.id,
      manager,
    );
  }

  Future<bool> deleteManager(Manager manager) async {
    return await delete(
      () => managerRepository.bookingManagersManagerIdDelete(
        managerId: manager.id,
      ),
      (manager) => manager.id,
      manager.id,
    );
  }
}

final managerListProvider =
    NotifierProvider<ManagerListNotifier, AsyncValue<List<Manager>>>(
      ManagerListNotifier.new,
    );
