import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_provider.dart';

class PlayersNotifier extends StateNotifier<Map<int, SimpleUser>> {
  PlayersNotifier() : super(<int, SimpleUser>{});

  void setPlayer(int playerIndex, SimpleUser user) {
    final copy = Map<int, SimpleUser>.from(state);
    copy[playerIndex] = user;
    state = Map<int, SimpleUser>.from(copy);
  }

  void reset() {
    state = {0: state.values.first};
  }
}

final playersProvider =
    StateNotifierProvider<PlayersNotifier, Map<int, SimpleUser>>((ref) {
  final me = ref.watch(userProvider);
  final notifier = PlayersNotifier();
  notifier.setPlayer(0, me.toSimpleUser());
  return notifier;
});
