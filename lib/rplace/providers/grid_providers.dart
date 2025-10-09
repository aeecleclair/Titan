import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/rplace/class/gridInfo.dart';
import 'package:titan/rplace/repositories/grid_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class gridNotifier extends SingleNotifier<gridInfo> {
  final gridRepository _gridRepository = gridRepository();
  gridNotifier({required String token}) : super(const AsyncLoading()) {
    _gridRepository.setToken(token);
  }

  Future<AsyncValue<gridInfo>> getGridInformation() async {
    return await load(_gridRepository.getGridInformation);
  }
}

final gridProvider = StateNotifierProvider<gridNotifier, AsyncValue<gridInfo>>((
  ref,
) {
  final token = ref.watch(tokenProvider);
  final notifier = gridNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getGridInformation();
  });
  return notifier;
});
