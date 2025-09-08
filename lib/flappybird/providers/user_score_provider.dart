import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/flappybird/class/score.dart';
import 'package:titan/flappybird/repositories/score_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class ScoreListNotifier extends SingleNotifier<Score> {
  final ScoreRepository _scoreRepository = ScoreRepository();
  ScoreListNotifier({required String token}) : super(const AsyncLoading()) {
    _scoreRepository.setToken(token);
  }

  Future<AsyncValue<Score>> getLeaderBoardPosition() async {
    return await load(_scoreRepository.getLeaderBoardPosition);
  }
}

final userScoreProvider =
    StateNotifierProvider<ScoreListNotifier, AsyncValue<Score>>((ref) {
      final token = ref.watch(tokenProvider);
      final notifier = ScoreListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.getLeaderBoardPosition();
      });
      return notifier;
    });
