import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ManagerListNotifier extends ListNotifier2<Manager> {
  final Openapi managerRepository;
  ManagerListNotifier({required this.managerRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Manager>>> loadManagers() async {
    return await loadList(managerRepository.bookingManagersGet);
  }

  Future<bool> addManager(Manager manager) async {
    return await add(
        (manager) async => managerRepository.bookingManagersPost(
                body: ManagerBase(
              name: manager.name,
              groupId: manager.groupId,
            )),
        manager);
  }

  Future<bool> updateManager(Manager manager) async {
    return await update(
        (manager) async => managerRepository.bookingManagersManagerIdPatch(
            managerId: manager.id,
            body: ManagerUpdate(
              name: manager.name,
              groupId: manager.groupId,
            )),
        (managers, manager) => managers
          ..[managers.indexWhere((m) => m.id == manager.id)] = manager,
        manager);
  }

  Future<bool> deleteManager(Manager manager) async {
    return await delete(
        (managerId) async => managerRepository.bookingManagersManagerIdDelete(
            managerId: managerId),
        (managers, manager) => managers..removeWhere((m) => m.id == manager.id),
        manager.id,
        manager);
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
