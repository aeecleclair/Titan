import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/booking/class/manager.dart';
import 'package:myecl/booking/repositories/manager_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserManagerListNotifier extends ListNotifier<Manager> {
  final ManagerRepository _repository = ManagerRepository();
  UserManagerListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _repository.setToken(token);
  }

  Future<AsyncValue<List<Manager>>> loadManagers() async {
    return await loadList(_repository.getMyManager);
  }
}

final userManagerListProvider =
    StateNotifierProvider<UserManagerListNotifier, AsyncValue<List<Manager>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final provider = UserManagerListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadManagers();
  });
  return provider;
});
