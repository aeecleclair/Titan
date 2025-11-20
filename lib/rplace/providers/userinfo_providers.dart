import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/rplace/class/userInfo.dart';
import 'package:titan/rplace/repositories/userinfo_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class UserinfoNotifier extends SingleNotifier<UserInfo> {
  final UserinfoRepository _userinfoRepository = UserinfoRepository();
  UserinfoNotifier({required String token}) : super(const AsyncLoading()) {
    _userinfoRepository.setToken(token);
  }

  Future<AsyncValue<UserInfo>> getLastPlacedDate() async {
    return await load(_userinfoRepository.getLastPlacedDate);
  }
}

final userinfoProvider =
    StateNotifierProvider<UserinfoNotifier, AsyncValue<UserInfo>>((ref) {
      final token = ref.watch(tokenProvider);
      final notifier = UserinfoNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.getLastPlacedDate();
      });
      return notifier;
    });
