import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/elocaps/repositories/players_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/user/providers/user_provider.dart';


class PlayerInfoEloNotifier extends SingleNotifier<Map<String, int>>{
  final PlayersRepository _playerDetailRepository = PlayersRepository();
  late String id;
  PlayerInfoEloNotifier({required String token}) : super(const AsyncValue.loading()) {
    _playerDetailRepository.setToken(token);
  }

  void setId(String Id) {
    this.id = Id;
  }

   Future<AsyncValue<Map<String, int>>> loadPlayerInfo({String? given_id}) async {
    return await load(() async => _playerDetailRepository.getPlayerInfo(given_id ?? id));
  }
}

final playerInfoProvider = StateNotifierProvider<PlayerInfoEloNotifier, AsyncValue<Map<String, int>>>((ref) {
  final token = ref.watch(tokenProvider);
  PlayerInfoEloNotifier notifier = PlayerInfoEloNotifier(token: token);
  final user = ref.watch(userProvider);
  notifier.setId(user.id);
  notifier.loadPlayerInfo();
    
  return notifier;
});