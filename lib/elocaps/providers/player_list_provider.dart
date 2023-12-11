import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/class/player.dart';
import 'package:myecl/elocaps/repositories/leaderboard_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';


class PlayerListNotifier extends ListNotifier<Player> {
  final LeaderBoardRepository _leaderboardrepository = LeaderBoardRepository();
  PlayerListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _leaderboardrepository.setToken(token);
  }

  Future<AsyncValue<List<Player>>> loadRanking() async {
    // List<Player> list = await _leaderboardrepository.getLeaderBoard("single")
    // ..addAll(await _leaderboardrepository.getLeaderBoard("cd"))
    // ..addAll(await _leaderboardrepository.getLeaderBoard("capacks"))
    // ..addAll(await _leaderboardrepository.getLeaderBoard("semiCapacks")); 
    
    return await loadList(
        () async => _leaderboardrepository.getLeaderBoard("single")); 
  }

}

final playerListProvider =
    StateNotifierProvider<PlayerListNotifier, AsyncValue<List<Player>>>((ref) {
  final token = ref.watch(tokenProvider);
  PlayerListNotifier notifier = PlayerListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadRanking();
  });
  return notifier;
});