

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/elocaps/class/game.dart';
import 'package:myecl/elocaps/repositories/players_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_provider.dart';

class HistoListNotifier extends ListNotifier<Game> {
  final PlayersRepository _playerRepository = PlayersRepository();
  HistoListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _playerRepository.setToken(token);
  }

  Future<AsyncValue<List<Game>>> loadHisto(String userId) async {
    return await loadList(() async => _playerRepository.getGamesList(userId));
  }

}

final playerHistoProvider = StateNotifierProvider<HistoListNotifier, AsyncValue<List<Game>>>((ref) {
  final token = ref.watch(tokenProvider);
  HistoListNotifier notifier = HistoListNotifier(token: token);
  final user = ref.watch(userProvider);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadHisto(user.id);
  });
  return notifier;
});