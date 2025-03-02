import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class RaffleStatsNotifier extends SingleNotifierAPI<RaffleStats> {
  final Openapi raffleDetailRepository;
  RaffleStatsNotifier({required this.raffleDetailRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<RaffleStats>> loadRaffleStats(
    String raffleId,
  ) async {
    return await load(
      () async => raffleDetailRepository.tombolaRafflesRaffleIdStatsGet(
        raffleId: raffleId,
      ),
    );
  }
}

final raffleStatsProvider = StateNotifierProvider.family<RaffleStatsNotifier,
    AsyncValue<RaffleStats>, String>((ref, raffleId) {
  final raffleDetailRepository = ref.watch(repositoryProvider);
  RaffleStatsNotifier notifier =
      RaffleStatsNotifier(raffleDetailRepository: raffleDetailRepository);
  notifier.loadRaffleStats(raffleId);
  return notifier;
});
