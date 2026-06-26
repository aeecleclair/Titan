import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class RaffleListNotifier extends ListNotifierAPI<RaffleComplete> {
  Openapi get raffleRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<RaffleComplete>> build() {
    loadRaffleList();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<RaffleComplete>>> loadRaffleList() async {
    return await loadList(raffleRepository.tombolaRafflesGet);
  }

  Future<bool> createRaffle(RaffleComplete raffle) async {
    return await localAdd(raffle);
  }

  Future<bool> updateRaffle(RaffleComplete raffle) async {
    return await localUpdate((raffle) => raffle.id, raffle);
  }

  Future<bool> deleteRaffle(RaffleComplete raffle) async {
    return await localDelete((raffle) => raffle.id, raffle.id);
  }

  Future<bool> openRaffle(RaffleComplete raffle) async {
    return await update(
      () =>
          raffleRepository.tombolaRafflesRaffleIdOpenPatch(raffleId: raffle.id),
      (raffle) => raffle.id,
      raffle.copyWith(status: RaffleStatusType.open),
    );
  }

  Future<bool> lockRaffle(RaffleComplete raffle) async {
    return await update(
      () =>
          raffleRepository.tombolaRafflesRaffleIdLockPatch(raffleId: raffle.id),
      (raffle) => raffle.id,
      raffle.copyWith(status: RaffleStatusType.lock),
    );
  }
}

final raffleListProvider =
    NotifierProvider<RaffleListNotifier, AsyncValue<List<RaffleComplete>>>(
      RaffleListNotifier.new,
    );
