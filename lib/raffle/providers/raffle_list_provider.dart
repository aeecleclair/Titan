import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class RaffleListNotifier extends ListNotifier2<RaffleComplete> {
  final Openapi raffleRepository;
  RaffleListNotifier({required this.raffleRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<RaffleComplete>>> loadRaffleList() async {
    return await loadList(raffleRepository.tombolaRafflesGet);
  }

  Future<bool> createRaffle(RaffleComplete raffle) async {
    return await localAdd(raffle);
  }

  Future<bool> updateRaffle(RaffleComplete raffle) async {
    return await localUpdate(
      (raffles, r) => raffles..[raffles.indexWhere((e) => e.id == r.id)] = r,
      raffle,
    );
  }

  Future<bool> deleteRaffle(RaffleComplete raffle) async {
    return await localDelete(
      (raffles, r) => raffles..removeWhere((e) => e.id == r.id),
      raffle,
    );
  }

  Future<bool> openRaffle(RaffleComplete raffle) async {
    return await update(
      () =>
          raffleRepository.tombolaRafflesRaffleIdOpenPatch(raffleId: raffle.id),
      (raffles, r) => raffles..[raffles.indexWhere((e) => e.id == r.id)] = r,
      raffle,
    );
  }

  Future<bool> lockRaffle(RaffleComplete raffle) async {
    return await update(
      () =>
          raffleRepository.tombolaRafflesRaffleIdLockPatch(raffleId: raffle.id),
      (raffles, r) => raffles..[raffles.indexWhere((e) => e.id == r.id)] = r,
      raffle,
    );
  }
}

final raffleListProvider =
    StateNotifierProvider<RaffleListNotifier, AsyncValue<List<RaffleComplete>>>(
        (ref) {
  final raffleRepository = ref.watch(repositoryProvider);
  RaffleListNotifier notifier =
      RaffleListNotifier(raffleRepository: raffleRepository);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadRaffleList();
  });
  return notifier;
});
