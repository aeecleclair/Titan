import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/raffle_status_type.dart';
import 'package:myecl/tombola/repositories/raffle_repositories.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

import 'package:myecl/admin/class/simple_group.dart';


class RaffleListNotifier extends ListNotifier<Raffle> {
  final RaffleRepository _rafflerepository = RaffleRepository();
  RaffleListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _rafflerepository.setToken(token);
  }

  Future<AsyncValue<List<Raffle>>> loadRaffleList() async {
return await loadList( () async => 
    [Raffle(name: "oui", group: SimpleGroup(name:"a",description: "b",id:"1f841bd9-00be-41a7-96e1-860a18a46105"), raffleStatusType: RaffleStatusType.creation, id: "1"),
    Raffle(name: "non", group: SimpleGroup(name:"a",description: "b",id:"1f841bd9-00be-41a7-96e1-860a18a46105"), raffleStatusType: RaffleStatusType.open, id: "2"),
    Raffle(name: "fini", group: SimpleGroup(name:"a",description: "b",id:"150"), raffleStatusType: RaffleStatusType.locked, id: "3"),]);
    //return await loadList(() async => _rafflerepository.getRaffleList());
  }

  Future<bool> createRaffle(Raffle raffle) async {
    return await add(
      // _rafflerepository.createRaffle,
      (raffle) async => raffle,
      raffle);
  }

  Future<bool> updateRaffle(Raffle raffle) async {
    return await update(
        // _rafflerepository.updateRaffle,
        (raffle) async => false,
        (raffles, r) => raffles..[raffles.indexWhere((e) => e.id == r.id)] = r,
        raffle);
  }

  Future<bool> deleteRaffle(Raffle raffle) async {
    return await delete(
        // _rafflerepository.deleteRaffle,
        (raffle) async => false,
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
