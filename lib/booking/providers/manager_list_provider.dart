import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/booking/class/manager.dart';
import 'package:titan/booking/repositories/manager_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class ManagerListNotifier extends ListNotifier<Manager> {
  final ManagerRepository _repository = ManagerRepository();
  ManagerListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    _repository.setToken(token);
  }

  Future<AsyncValue<List<Manager>>> loadManagers() async {
    return await loadList(_repository.getManagerList);
  }

  Future<bool> addManager(Manager manager) async {
    return await add(_repository.createManager, manager);
  }

  Future<bool> updateManager(Manager manager) async {
    return await update(
      _repository.updateManager,
      (managers, manager) =>
          managers..[managers.indexWhere((m) => m.id == manager.id)] = manager,
      manager,
    );
  }

  Future<bool> deleteManager(Manager manager) async {
    return await delete(
      _repository.deleteManager,
      (managers, manager) => managers..removeWhere((m) => m.id == manager.id),
      manager.id,
      manager,
    );
  }
}

final managerListProvider =
    StateNotifierProvider<ManagerListNotifier, AsyncValue<List<Manager>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      final provider = ManagerListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadManagers();
      });
      return provider;
    });
