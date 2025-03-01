import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/meme/class/meme_score.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/sorting_score_time_bar_provider.dart';
import 'package:myecl/meme/repositories/leaderboard_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MyScoreNotifier extends SingleNotifier<MemeScore> {
  final _memeRepository = MemeScoreRepository();
  MyScoreNotifier({required String token}) : super(const AsyncLoading()) {
    _memeRepository.setToken(token);
  }

  Future<AsyncValue<MemeScore>> getLeaderBoardPosition(Period p) async {
    return await load(() => _memeRepository.getMyScore(p));
  }
}

final myScoreProvider =
    StateNotifierProvider<MyScoreNotifier, AsyncValue<MemeScore>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = MyScoreNotifier(token: token);
  final period = ref.watch(selectedSortingScoreTimeProvider);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getLeaderBoardPosition(period);
  });
  return notifier;
});
