import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/rplace/class/gridInfo.dart';
import 'package:titan/rplace/repositories/grid_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class GridNotifier extends SingleNotifier<GridInfo> {
  final GridRepository _gridRepository = GridRepository();
  GridNotifier({required String token}) : super(const AsyncLoading()) {
    _gridRepository.setToken(token);
  }

  Future<AsyncValue<GridInfo>> getGridInformation() async {
    return await load(_gridRepository.getGridInformation);
  }
}

final gridProvider = StateNotifierProvider<GridNotifier, AsyncValue<GridInfo>>((
  ref,
) {
  final token = ref.watch(tokenProvider);
  final notifier = GridNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getGridInformation();
  });
  return notifier;
});
