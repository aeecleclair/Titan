import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/elocaps/class/player.dart';
import 'package:myecl/elocaps/providers/player_id_provider.dart';
import 'package:myecl/elocaps/repositories/players_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';


class PlayerInfoNotifier extends SingleNotifier<Player>{
  final PlayersRepository _playerDetailRepository = PlayersRepository();
  late String id;
  PlayerInfoNotifier({required String token}) : super(const AsyncValue.loading()) {
    _playerDetailRepository.setToken(token);
  }

  void setId(String Id) {
    this.id = Id;
  }

   Future<AsyncValue<Player>> loadPlayerInfo({String? given_id}) async {
    return await load(() async => _playerDetailRepository.getPlayerInfo(given_id ?? id));
  }
}

final playerInfoProvider = StateNotifierProvider<PlayerInfoNotifier, AsyncValue<Player>>((ref) {
  final token = ref.watch(tokenProvider);
  PlayerInfoNotifier notifier = PlayerInfoNotifier(token: token);
  final raffleId = ref.watch(playerIdProvider);
    if (raffleId != Player.empty().id) {
      notifier.setId(raffleId);
      notifier.loadPlayerInfo();
    }
  return notifier;
});