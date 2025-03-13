import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserManagerListNotifier extends ListNotifierAPI<Manager> {
  final Openapi managerRepository;
  UserManagerListNotifier({required this.managerRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Manager>>> loadManagers() async {
    return await loadList(managerRepository.bookingManagersUsersMeGet);
  }
}

final userManagerListProvider =
    StateNotifierProvider<UserManagerListNotifier, AsyncValue<List<Manager>>>(
        (ref) {
  final managerRepository = ref.watch(repositoryProvider);
  return UserManagerListNotifier(managerRepository: managerRepository)
    ..loadManagers();
});
