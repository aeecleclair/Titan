import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/flappybird/class/score.dart';
import 'package:myecl/flappybird/repositories/score_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ScoreListNotifier extends ListNotifier<Score> {
  final ScoreRepository _scoreRepository = ScoreRepository();
  ScoreListNotifier({required String token}) : super(const AsyncLoading()) {
    _scoreRepository.setToken(token);
  }

  Future<AsyncValue<List<Score>>> getLeaderboard() async {
    return await loadList(_scoreRepository.getLeaderboard);
  }

  Future<bool> createScore(Score score) async {
    return await add(_scoreRepository.createScore, score);
  }
}

final scoreListProvider =
    StateNotifierProvider<ScoreListNotifier, AsyncValue<List<Score>>>((ref) {
      final token = ref.watch(tokenProvider);
      final notifier = ScoreListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.getLeaderboard();
      });
      return notifier;
    });
