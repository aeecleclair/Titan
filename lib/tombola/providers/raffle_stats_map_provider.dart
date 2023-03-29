import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tombola/class/stats.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class RaffleStatsMapNotifier extends MapNotifier<String, RaffleStats> {
  RaffleStatsMapNotifier() : super();
}

final raffleStatsMapProvider = StateNotifierProvider<
    RaffleStatsMapNotifier,
    AsyncValue<Map<String, AsyncValue<List<RaffleStats>>>>>((ref) {
  RaffleStatsMapNotifier notifier = RaffleStatsMapNotifier();
  tokenExpireWrapperAuth(ref, () async {
    final raffles = ref.watch(raffleListProvider);
    raffles.whenData((value) {
      notifier.loadTList(value.map((e) => e.id).toList());
    });
  });
  return notifier;
});
