import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/class/cmm_score.dart';
import 'package:myecl/CMM/repositories/leaderboard_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ScoreListNotifier extends ListNotifier<CMMScore> {
  final CMMScoreRepository _scoreRepository = CMMScoreRepository();
  ScoreListNotifier({required String token}) : super(const AsyncLoading()) {
    _scoreRepository.setToken(token);
  }

  Future<AsyncValue<List<CMMScore>>> getLeaderboard() async {
    return await loadList(_scoreRepository.getLeaderboard);
  }

  Future<bool> createScore(CMMScore score) async {
    return await add(_scoreRepository.createCMMScore, score);
  }
}

final scoreListProvider =
    StateNotifierProvider<ScoreListNotifier, AsyncValue<List<CMMScore>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = ScoreListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getLeaderboard();
  });
  return notifier;
});
