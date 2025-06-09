import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/class/raffle.dart';
import 'package:myecl/raffle/class/stats.dart';
import 'package:myecl/raffle/providers/raffle_id_provider.dart';
import 'package:myecl/raffle/repositories/raffle_detail_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class RaffleStatsNotifier extends SingleNotifier<RaffleStats> {
  final RaffleDetailRepository _raffleDetailRepository;
  late String raffleId;
  RaffleStatsNotifier(this._raffleDetailRepository)
    : super(const AsyncValue.loading());

  void setRaffleId(String raffleId) {
    this.raffleId = raffleId;
  }

  Future<AsyncValue<RaffleStats>> loadRaffleStats({
    String? customRaffleId,
  }) async {
    return await load(
      () async =>
          _raffleDetailRepository.getRaffleStats(customRaffleId ?? raffleId),
    );
  }
}

final raffleStatsProvider =
    StateNotifierProvider<RaffleStatsNotifier, AsyncValue<RaffleStats>>((ref) {
      final raffleDetailRepository = ref.watch(raffleDetailRepositoryProvider);
      RaffleStatsNotifier notifier = RaffleStatsNotifier(
        raffleDetailRepository,
      );
      final raffleId = ref.watch(raffleIdProvider);
      if (raffleId != Raffle.empty().id) {
        notifier.setRaffleId(raffleId);
        notifier.loadRaffleStats();
      }
      return notifier;
    });
