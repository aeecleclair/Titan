import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/class/cmm_score.dart';
import 'package:myecl/CMM/class/utils.dart';
import 'package:myecl/CMM/providers/sorting_score_time_bar_provider.dart';
import 'package:myecl/CMM/repositories/leaderboard_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class FloorCMMScoreListNotifier extends ListNotifier<CMMScoreFloor> {
  final _cmmScoreRepository = CMMScoreRepository();
  FloorCMMScoreListNotifier({required String token})
      : super(const AsyncLoading()) {
    _cmmScoreRepository.setToken(token);
  }

  Future<AsyncValue<List<CMMScoreFloor>>> getFloorLeaderboard(Period p) async {
    return await loadList(() => _cmmScoreRepository.getFloorLeaderboard(p));
  }
}

final floorCMMScoreListProvider = StateNotifierProvider<
    FloorCMMScoreListNotifier, AsyncValue<List<CMMScoreFloor>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = FloorCMMScoreListNotifier(token: token);
  final period = ref.watch(selectedSortingScoreTimeProvider);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getFloorLeaderboard(period);
  });
  return notifier;
});
