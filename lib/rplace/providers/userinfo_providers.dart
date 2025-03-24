import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/rplace/class/userInfo.dart';
import 'package:myecl/rplace/repositories/userinfo_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class userinfoNotifier extends SingleNotifier<UserInfo> {
  final UserinfoRepository _userinfoRepository = UserinfoRepository();
  userinfoNotifier({required String token}) : super(const AsyncLoading()) {
    _userinfoRepository.setToken(token);
  }

  Future<AsyncValue<UserInfo>> getLastPlacedDate() async {
    return await load(_userinfoRepository.getLastPlacedDate);
  }
}

final userinfoProvider =
    StateNotifierProvider<userinfoNotifier, AsyncValue<UserInfo>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = userinfoNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getLastPlacedDate();
  });
  return notifier;
});
