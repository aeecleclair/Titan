import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class RaffleListNotifier extends ListNotifier2<RaffleComplete> {
  final Openapi raffleRepository;
  RaffleListNotifier({required this.raffleRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<RaffleComplete>>> loadRaffleList() async {
    return await loadList(raffleRepository.tombolaRafflesGet);
  }

  Future<bool> createRaffle(RaffleComplete raffle) async {
    return await add(
        (raffle) async => raffleRepository.tombolaRafflesPost(
                // TODO: RaffleBase
                body: RaffleBase(
              name: raffle.name,
              status: raffle.status,
              description: raffle.description,
              groupId: raffle.groupId,
            )),
        raffle);
  }

  Future<bool> updateRaffle(RaffleComplete raffle) async {
    return await update(
        (raffle) async => raffleRepository.tombolaRafflesRaffleIdPatch(
            raffleId: raffle.id,
            body: RaffleEdit(
              name: raffle.name,
              description: raffle.description,
            )),
        (raffles, r) => raffles..[raffles.indexWhere((e) => e.id == r.id)] = r,
        raffle);
  }

  Future<bool> deleteRaffle(RaffleComplete raffle) async {
    return await delete(
        (raffleId) async =>
            raffleRepository.tombolaRafflesRaffleIdDelete(raffleId: raffleId),
        (raffles, r) => raffles..removeWhere((e) => e.id == r.id),
        raffle.id,
        raffle);
  }

  Future<bool> openRaffle(RaffleComplete openedRaffle) async {
    return await update(
        (raffle) async => raffleRepository.tombolaRafflesRaffleIdOpenPatch(
            raffleId: raffle.id),
        (raffles, r) => raffles..[raffles.indexWhere((e) => e.id == r.id)] = r,
        openedRaffle);
  }

  Future<bool> lockRaffle(RaffleComplete lockedRaffle) async {
    return await update(
        (raffle) async => raffleRepository.tombolaRafflesRaffleIdLockPatch(
            raffleId: raffle.id),
        (raffles, r) => raffles..[raffles.indexWhere((e) => e.id == r.id)] = r,
        lockedRaffle);
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
