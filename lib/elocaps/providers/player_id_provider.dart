import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/elocaps/providers/player_list_provider.dart';

final playerIdProvider =
    StateNotifierProvider<PlayerIdProvider, String>((ref) {
  final players = ref.watch(playerListProvider);
  return players.when(
      data: (data) {
        return PlayerIdProvider(data.first.id);
      },
      error: (_, __) => PlayerIdProvider(""),
      loading: () => PlayerIdProvider(""));
});

class PlayerIdProvider extends StateNotifier<String> {
  PlayerIdProvider(String id) : super(id);

  void setId(String i) {
    state = i;
  }
}