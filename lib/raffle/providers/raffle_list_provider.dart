import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/raffle/class/raffle.dart';
import 'package:myecl/raffle/repositories/raffle_repositories.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class RaffleListNotifier extends ListNotifier<Raffle> {
  final RaffleRepository raffleRepository;
  RaffleListNotifier(this.raffleRepository) : super(const AsyncValue.loading());

  Future<AsyncValue<List<Raffle>>> loadRaffleList() async {
    return await loadList(() async => raffleRepository.getRaffleList());
  }

  Future<bool> createRaffle(Raffle raffle) async {
    return await add((raffle) async => raffle, raffle);
  }

  Future<bool> updateRaffle(Raffle raffle) async {
    return await update(
      (raffle) async => false,
      (raffles, r) => raffles..[raffles.indexWhere((e) => e.id == r.id)] = r,
      raffle,
    );
  }

  Future<bool> deleteRaffle(Raffle raffle) async {
    return await delete(
      (raffle) async => false,
      (raffles, r) => raffles..removeWhere((e) => e.id == r.id),
      raffle.id,
      raffle,
    );
  }

  Future<bool> openRaffle(Raffle openedRaffle) async {
    return await update(
      raffleRepository.updateRaffle,
      (raffles, r) => raffles..[raffles.indexWhere((e) => e.id == r.id)] = r,
      openedRaffle,
    );
  }

  Future<bool> lockRaffle(Raffle lockedRaffle) async {
    return await update(
      raffleRepository.updateRaffle,
      (raffles, r) => raffles..[raffles.indexWhere((e) => e.id == r.id)] = r,
      lockedRaffle,
    );
  }
}

final raffleListProvider =
    StateNotifierProvider<RaffleListNotifier, AsyncValue<List<Raffle>>>((ref) {
      final raffleRepository = ref.watch(raffleRepositoryProvider);
      RaffleListNotifier notifier = RaffleListNotifier(raffleRepository);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadRaffleList();
      });
      return notifier;
    });
