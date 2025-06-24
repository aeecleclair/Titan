import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/raffle/class/stats.dart';
import 'package:titan/raffle/providers/raffle_list_provider.dart';
import 'package:titan/tools/providers/map_provider.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class RaffleStatsMapNotifier extends MapNotifier<String, RaffleStats> {
  RaffleStatsMapNotifier() : super();
}

final raffleStatsMapProvider =
    StateNotifierProvider<
      RaffleStatsMapNotifier,
      Map<String, AsyncValue<List<RaffleStats>>?>
    >((ref) {
      RaffleStatsMapNotifier notifier = RaffleStatsMapNotifier();
      tokenExpireWrapperAuth(ref, () async {
        final raffles = ref.watch(raffleListProvider);
        raffles.whenData((value) {
          notifier.loadTList(value.map((e) => e.id).toList());
        });
      });
      return notifier;
    });
