import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/manager.dart';
import 'package:myecl/booking/repositories/manager_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class UserManagerListNotifier extends ListNotifier<Manager> {
  final ManagerRepository managerRepository;
  UserManagerListNotifier(this.managerRepository)
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Manager>>> loadManagers() async {
    return await loadList(managerRepository.getUserManagerList);
  }
}

final userManagerListProvider =
    StateNotifierProvider<UserManagerListNotifier, AsyncValue<List<Manager>>>((
      ref,
    ) {
      final managerRepository = ref.watch(managerRepositoryProvider);
      final provider = UserManagerListNotifier(managerRepository);
      provider.loadManagers();
      return provider;
    });
