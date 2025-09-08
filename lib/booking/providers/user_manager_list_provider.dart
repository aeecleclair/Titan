import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/booking/class/manager.dart';
import 'package:titan/booking/repositories/manager_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class UserManagerListNotifier extends ListNotifier<Manager> {
  final ManagerRepository managerRepository = ManagerRepository();
  UserManagerListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    managerRepository.setToken(token);
  }

  Future<AsyncValue<List<Manager>>> loadManagers() async {
    return await loadList(managerRepository.getUserManagerList);
  }
}

final userManagerListProvider =
    StateNotifierProvider<UserManagerListNotifier, AsyncValue<List<Manager>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      final provider = UserManagerListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadManagers();
      });
      return provider;
    });
