import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class RaffleListNotifier extends ListNotifierAPI<RaffleComplete> {
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
      (raffle) => raffle.id,
      raffle,
    );
  }

  Future<bool> deleteRaffle(RaffleComplete raffle) async {
    return await localDelete(
      (r) => r.id,
      raffle.id,
    );
  }

  Future<bool> openRaffle(RaffleComplete raffle) async {
    return await update(
      () =>
          raffleRepository.tombolaRafflesRaffleIdOpenPatch(raffleId: raffle.id),
      (raffle) => raffle.id,
      raffle,
    );
  }

  Future<bool> lockRaffle(RaffleComplete raffle) async {
    return await update(
      () =>
          raffleRepository.tombolaRafflesRaffleIdLockPatch(raffleId: raffle.id),
      (raffle) => raffle.id,
      raffle,
    );
  }
}

final raffleListProvider =
    StateNotifierProvider<RaffleListNotifier, AsyncValue<List<RaffleComplete>>>(
        (ref) {
  final raffleRepository = ref.watch(repositoryProvider);
  return RaffleListNotifier(raffleRepository: raffleRepository)
    ..loadRaffleList();
});
