import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/class/cmm_score.dart';
import 'package:myecl/CMM/repositories/leaderboard_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class CMMScoreNotifier extends SingleNotifier<CMMScore> {
  final CMMScoreRepository _scoreRepository = CMMScoreRepository();
  CMMScoreNotifier({required String token}) : super(const AsyncLoading()) {
    _scoreRepository.setToken(token);
  }

  Future<AsyncValue<CMMScore>> getLeaderBoardPosition() async {
    return await load(_scoreRepository.getLeaderBoardPosition);
  }
}

final userCMMScoreProvider =
    StateNotifierProvider<CMMScoreNotifier, AsyncValue<CMMScore>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = CMMScoreNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getLeaderBoardPosition();
  });
  return notifier;
});
