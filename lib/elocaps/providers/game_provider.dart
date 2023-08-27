import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/elocaps/class/game.dart';
import 'package:myecl/elocaps/repositories/game_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class GameNotifier extends SingleNotifier<Game>{
  final GameRepository _gameRepository = GameRepository();
  GameNotifier({required String token}) : super(const AsyncValue.loading()) {
    _gameRepository.setToken(token);
  }


  Future<AsyncValue<Game>> createGame(Game game) async {
    return await load(() async => _gameRepository.createGame(game));
  }


}

final gameProvider = StateNotifierProvider<GameNotifier, AsyncValue<Game>>((ref) {
  final token = ref.watch(tokenProvider);
  GameNotifier notifier = GameNotifier(token: token);

  return notifier;
});