import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/raffle/providers/raffle_list_provider.dart';
import 'package:titan/tools/providers/map_provider.dart';

class RaffleStatsMapNotifier extends MapNotifier<String, RaffleStats> {
  @override
  Map<String, AsyncValue<List<RaffleStats>>?> build() {
    final raffles = ref.watch(raffleListProvider);
    raffles.whenData((value) {
      loadTList(value.map((e) => e.id).toList());
    });
    return state;
  }
}

final raffleStatsMapProvider =
    NotifierProvider<
      RaffleStatsMapNotifier,
      Map<String, AsyncValue<List<RaffleStats>>?>
    >(() => RaffleStatsMapNotifier());
