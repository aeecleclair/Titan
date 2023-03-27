import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/raffle_status_type.dart';
import 'package:myecl/tombola/repositories/raffle_repositories.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class RaffleListNotifier extends ListNotifier<Raffle> {
  final RaffleRepository _rafflerepository = RaffleRepository();
  RaffleListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _rafflerepository.setToken(token);
  }

  Future<AsyncValue<List<Raffle>>> loadRaffleList() async {
    // return await loadList(
    //     () async => _rafflerepository.getRaffleList(raffleId));
    return state = AsyncData([
      Raffle(
          id: '1',
          name: 'Tombola Soli Sida',
          raffleStatusType: RaffleStatusType.creation,
          group: SimpleGroup.empty(),
          description: "SDRFTGHYUJIKRTJRSTHEQRG"),
      Raffle(
          id: '2',
          name: 'Tombola Test',
          raffleStatusType: RaffleStatusType.open,
          group: SimpleGroup.empty(),
          description:
              "Facilis error amet. Quia sint aspernatur aut. Asperiores expedita dolorem."),
      Raffle(
          id: 'azertyuiop',
          name: 'Tombola Test2',
          raffleStatusType: RaffleStatusType.locked,
          group: SimpleGroup.empty(),
          description:
              "Dolorum et consectetur. Maxime asperiores ratione delectus labore. Officiis mollitia consequatur qui et voluptas. Aut aliquam et tempore rerum saepe quam."),
    ]);
  }

  Future<bool> createRaffle(Raffle raffle) async {
    return await add(_rafflerepository.createRaffle, raffle);
  }

  Future<bool> updateRaffle(Raffle raffle) async {
    return await update(
        _rafflerepository.updateRaffle,
        (raffles, r) => raffles..[raffles.indexWhere((e) => e.id == r.id)] = r,
        raffle);
  }

  Future<bool> deleteRaffle(Raffle raffle) async {
    return await delete(
        _rafflerepository.deleteRaffle,
        (raffles, r) => raffles..removeWhere((e) => e.id == r.id),
        raffle.id,
        raffle);
  }

  Future<bool> openRaffle(Raffle opennedRaffle) async {
    return await update(
        _rafflerepository.updateRaffle,
        (raffles, r) => raffles..[raffles.indexWhere((e) => e.id == r.id)] = r,
        opennedRaffle);
  }

  Future<bool> lockRaffle(Raffle lockedRaffle) async {
    return await update(
        _rafflerepository.updateRaffle,
        (raffles, r) => raffles..[raffles.indexWhere((e) => e.id == r.id)] = r,
        lockedRaffle);
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
