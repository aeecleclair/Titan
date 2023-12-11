import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/class/player.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class LeaderBoardPlayerListNotifier extends MapNotifier<CapsMode, Player> {
  LeaderBoardPlayerListNotifier() : super();
}

final leaderBoardPlayerListProvider = StateNotifierProvider<
    LeaderBoardPlayerListNotifier,
    AsyncValue<Map<CapsMode, AsyncValue<List<Player>>>>>((ref) {
  LeaderBoardPlayerListNotifier notifier = LeaderBoardPlayerListNotifier();
  notifier.loadTList(CapsMode.values);
  return notifier;
});
