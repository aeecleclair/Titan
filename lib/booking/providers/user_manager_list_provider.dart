import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserManagerListNotifier extends ListNotifier2<Manager> {
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
  final provider =
      UserManagerListNotifier(managerRepository: managerRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadManagers();
  });
  return provider;
});
