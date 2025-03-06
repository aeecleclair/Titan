import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/raffle/providers/raffle_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class RaffleStatsMapNotifier extends MapNotifier<String, RaffleStats> {
  RaffleStatsMapNotifier() : super();
}

final raffleStatsMapProvider = StateNotifierProvider<RaffleStatsMapNotifier,
    Map<String, AsyncValue<List<RaffleStats>>?>>((ref) {
  RaffleStatsMapNotifier notifier = RaffleStatsMapNotifier();
  final raffles = ref.watch(raffleListProvider);
  raffles.whenData((value) {
    notifier.loadTList(value.map((e) => e.id).toList());
  });
  return notifier;
});
