import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/flap/class/score.dart';
import 'package:myecl/flap/repositories/score_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ScoreListNotifier extends SingleNotifier<Score> {
  final ScoreRepository _scoreRepository = ScoreRepository();
  ScoreListNotifier({required String token}) : super(const AsyncLoading()) {
    _scoreRepository.setToken(token);
  }

  Future<AsyncValue<Score>> getLeaderBoardPosition() async {
    return await load(_scoreRepository.getLeaderBoardPosition);
  }
}

final userScoreProvider = StateNotifierProvider<ScoreListNotifier, AsyncValue<Score>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = ScoreListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getLeaderBoardPosition();
  });
  return notifier;
});