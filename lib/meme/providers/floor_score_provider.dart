import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/meme/class/meme_score.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/sorting_score_time_bar_provider.dart';
import 'package:myecl/meme/repositories/leaderboard_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class FloorMemeScoreListNotifier extends ListNotifier<MemeScoreFloor> {
  final _memeScoreRepository = MemeScoreRepository();
  FloorMemeScoreListNotifier({required String token})
      : super(const AsyncLoading()) {
    _memeScoreRepository.setToken(token);
  }

  Future<AsyncValue<List<MemeScoreFloor>>> getFloorLeaderboard(Period p) async {
    return await loadList(() => _memeScoreRepository.getFloorLeaderboard(p));
  }
}

final floorMemeScoreListProvider = StateNotifierProvider<
    FloorMemeScoreListNotifier, AsyncValue<List<MemeScoreFloor>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = FloorMemeScoreListNotifier(token: token);
  final period = ref.watch(selectedSortingScoreTimeProvider);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getFloorLeaderboard(period);
  });
  return notifier;
});
