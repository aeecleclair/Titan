import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/raffle/providers/raffle_id_provider.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class RaffleStatsNotifier extends SingleNotifierAPI<RaffleStats> {
  Openapi get raffleDetailRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<RaffleStats> build() {
    final currentRaffleId = ref.watch(raffleIdProvider);
    if (currentRaffleId != RaffleComplete.empty().id) {
      loadRaffleStats(currentRaffleId);
    }
    return const AsyncValue.loading();
  }

  Future<AsyncValue<RaffleStats>> loadRaffleStats(String raffleId) async {
    return await load(
      () async => raffleDetailRepository.tombolaRafflesRaffleIdStatsGet(
        raffleId: raffleId,
      ),
    );
  }
}

final raffleStatsProvider =
    NotifierProvider<RaffleStatsNotifier, AsyncValue<RaffleStats>>(
      RaffleStatsNotifier.new,
    );
