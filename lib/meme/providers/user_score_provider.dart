import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/meme/class/meme_score.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/sorting_score_time_bar_provider.dart';
import 'package:myecl/meme/repositories/leaderboard_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserMemeScoreListNotifier extends ListNotifier<MemeScoreUser> {
  final _memeScoreRepository = MemeScoreRepository();
  UserMemeScoreListNotifier({required String token})
      : super(const AsyncLoading()) {
    _memeScoreRepository.setToken(token);
  }

  Future<AsyncValue<List<MemeScoreUser>>> getUserLeaderboard(Period p) async {
    return await loadList(() => _memeScoreRepository.getUserLeaderboard(p));
  }
}

final userMemeScoreListProvider = StateNotifierProvider<
    UserMemeScoreListNotifier, AsyncValue<List<MemeScoreUser>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = UserMemeScoreListNotifier(token: token);
  final period = ref.watch(selectedSortingScoreTimeProvider);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getUserLeaderboard(period);
  });
  return notifier;
});
