import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/elocaps/class/player.dart';
import 'package:myecl/elocaps/repositories/players_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/user/providers/user_provider.dart';

class PlayerInfoEloNotifier extends ListNotifier<Player> {
  final PlayersRepository _playerDetailRepository = PlayersRepository();
  late String id;
  PlayerInfoEloNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _playerDetailRepository.setToken(token);
  }

  void setId(String Id) {
    id = Id;
  }

  Future<AsyncValue<List<Player>>> loadPlayerInfo({String? given_id}) async {
    return await loadList(
        () async => _playerDetailRepository.getPlayerInfo(given_id ?? id));
  }
}

final playerInfoProvider =
    StateNotifierProvider<PlayerInfoEloNotifier, AsyncValue<List<Player>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  PlayerInfoEloNotifier notifier = PlayerInfoEloNotifier(token: token);
  final user = ref.watch(userProvider);
  notifier.setId(user.id);
  notifier.loadPlayerInfo();

  return notifier;
});
