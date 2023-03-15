import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/flap/class/score.dart';
import 'package:myecl/flap/repositories/score_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class HistoryScoreListNotifier extends ListNotifier<Score> {
  final ScoreRepository _scoreRepository = ScoreRepository();
  HistoryScoreListNotifier({required String token}) : super(const AsyncLoading()) {
    _scoreRepository.setToken(token);
  }

  Future<AsyncValue<List<Score>>> getHistory() async {
    return await loadList(_scoreRepository.getHistory);
  }
}

final historyScoreListProvider = StateNotifierProvider<HistoryScoreListNotifier, AsyncValue<List<Score>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = HistoryScoreListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getHistory();
  });
  return notifier;
});