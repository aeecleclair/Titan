import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/class/cmm_score.dart';
import 'package:myecl/CMM/class/utils.dart';
import 'package:myecl/CMM/providers/sorting_score_bar_provider.dart';
import 'package:myecl/CMM/repositories/leaderboard_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserCMMScoreListNotifier extends ListNotifier<CMMScore> {
  final _cmmScoreRepository = CMMScoreRepository();
  UserCMMScoreListNotifier({required String token})
      : super(const AsyncLoading()) {
    _cmmScoreRepository.setToken(token);
  }

  Future<AsyncValue<List<CMMScore>>> getLeaderboard(Period p) async {
    return await loadList(() => _cmmScoreRepository.getLeaderboard(p));
  }
}

final userCMMScoreListProvider =
    StateNotifierProvider<UserCMMScoreListNotifier, AsyncValue<List<CMMScore>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final notifier = UserCMMScoreListNotifier(token: token);
  final period = ref.watch(selectedSortingScoreProvider);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getLeaderboard(period);
  });
  return notifier;
});
