import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/rplace/class/gridInfo.dart';
import 'package:myecl/rplace/repositories/grid_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class gridNotifier extends SingleNotifier<gridInfo> {
  final gridRepository _gridRepository = gridRepository();
  gridNotifier({required String token}) : super(const AsyncLoading()) {
    _gridRepository.setToken(token);
  }

  Future<AsyncValue<gridInfo>> getGridInformation() async {
    return await load(_gridRepository.getGridInformation);
  }
}

final gridProvider =
    StateNotifierProvider<gridNotifier, AsyncValue<gridInfo>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = gridNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getGridInformation();
  });
  return notifier;
});
