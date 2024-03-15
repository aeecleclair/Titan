import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_provider.dart';

class PlayersNotifier extends StateNotifier<Map<int, SimpleUser>> {
  PlayersNotifier() : super(<int, SimpleUser>{});

  void setPlayer(int playerIndex, SimpleUser user) {
    state[playerIndex] = user;
  }
}

final playersProvider =
    StateNotifierProvider<PlayersNotifier, Map<int, SimpleUser>>((ref) {
  final me = ref.watch(userProvider);
  final notifier = PlayersNotifier();
  notifier.setPlayer(0, me.toSimpleUser());
  return notifier;
});
