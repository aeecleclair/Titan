import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/raffle/class/raffle.dart';
import 'package:titan/raffle/repositories/raffle_repositories.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class RaffleListNotifier extends ListNotifier<Raffle> {
  final RaffleRepository raffleRepository = RaffleRepository();
  RaffleListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    raffleRepository.setToken(token);
  }

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
      final token = ref.watch(tokenProvider);
      RaffleListNotifier notifier = RaffleListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadRaffleList();
      });
      return notifier;
    });
