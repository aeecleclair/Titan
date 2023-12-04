import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/raffle/providers/raffle_id_provider.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';

class RaffleStatsNotifier extends SingleNotifier2<RaffleStats> {
  final Openapi raffleDetailRepository;
  RaffleStatsNotifier({required this.raffleDetailRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<RaffleStats>> loadRaffleStats(String raffleId) async {
    return await load(() async => raffleDetailRepository
        .tombolaRafflesRaffleIdStatsGet(raffleId: raffleId));
  }
}

final raffleStatsProvider =
    StateNotifierProvider<RaffleStatsNotifier, AsyncValue<RaffleStats>>((ref) {
  final raffleDetailRepository = ref.watch(repositoryProvider);
  RaffleStatsNotifier notifier =
      RaffleStatsNotifier(raffleDetailRepository: raffleDetailRepository);
  final raffleId = ref.watch(raffleIdProvider);
  if (raffleId != RaffleSimple.fromJson({}).id) {
    notifier.loadRaffleStats(raffleId);
  }
  return notifier;
});
