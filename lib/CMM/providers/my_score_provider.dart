import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/class/cmm_score.dart';
import 'package:myecl/CMM/class/utils.dart';
import 'package:myecl/CMM/providers/sorting_score_time_bar_provider.dart';
import 'package:myecl/CMM/repositories/leaderboard_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MyScoreNotifier extends SingleNotifier<CMMScore> {
  final _cmmRepository = CMMScoreRepository();
  MyScoreNotifier({required String token}) : super(const AsyncLoading()) {
    _cmmRepository.setToken(token);
  }

  Future<AsyncValue<CMMScore>> getLeaderBoardPosition(Period p) async {
    return await load(() => _cmmRepository.getMyScore(p));
  }
}

final myScoreProvider =
    StateNotifierProvider<MyScoreNotifier, AsyncValue<CMMScore>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = MyScoreNotifier(token: token);
  final period = ref.watch(selectedSortingScoreTimeProvider);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getLeaderBoardPosition(period);
  });
  return notifier;
});
