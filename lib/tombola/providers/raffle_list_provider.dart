import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/raffle.dart';
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
          startDate: DateTime.now().subtract(const Duration(days: 15)),
          groupId: '',
          endDate: DateTime.now().add(const Duration(days: 2)),
          description: "SDRFTGHYUJIKRTJRSTHEQRG"),
      Raffle(
          id: '2',
          name: 'Tombola Test',
          startDate: DateTime.now().subtract(const Duration(days: 1)),
          groupId: '',
          endDate: DateTime.now().add(const Duration(days: 20)),
          description:
              "Facilis error amet. Quia sint aspernatur aut. Asperiores expedita dolorem."),
      Raffle(
          id: 'azertyuiop',
          name: 'Tombola Test2',
          startDate: DateTime.now().add(const Duration(days: 10)),
          groupId: '',
          endDate: DateTime.now().add(const Duration(days: 32)),
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
