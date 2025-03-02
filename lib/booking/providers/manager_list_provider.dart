import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/booking/adapters/manager.dart';

class ManagerListNotifier extends ListNotifierAPI<Manager> {
  final Openapi managerRepository;
  ManagerListNotifier({required this.managerRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Manager>>> loadManagers() async {
    return await loadList(managerRepository.bookingManagersGet);
  }

  Future<bool> addManager(ManagerBase manager) async {
    return await add(
        () => managerRepository.bookingManagersPost(body: manager), manager);
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

  Future<bool> deleteManager(String managerId) async {
    return await delete(
      () => managerRepository.bookingManagersManagerIdDelete(
          managerId: managerId),
      (m) => m.id,
      managerId,
    );
  }
}

final managerListProvider =
    StateNotifierProvider<ManagerListNotifier, AsyncValue<List<Manager>>>(
        (ref) {
  final managerRepository = ref.watch(repositoryProvider);
  final provider = ManagerListNotifier(managerRepository: managerRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadManagers();
  });
  return provider;
});
