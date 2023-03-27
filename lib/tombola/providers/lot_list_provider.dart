import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/providers/raffle_id_provider.dart';
import 'package:myecl/tombola/repositories/lots_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class LotListNotifier extends ListNotifier<Lot> {
  final LotRepository _lotRepository = LotRepository();
  late String raffleId;
  LotListNotifier({required String token}) : super(const AsyncValue.loading()) {
    _lotRepository.setToken(token);
  }

  void setRaffleId(String id) {
    raffleId = id;
  }

  Future<AsyncValue<List<Lot>>> loadLotList() async {
    // return await loadList(
    //     () async => _lotRepository.getLotList(raffleId));
    return state = AsyncData([
      Lot(raffle: Raffle.empty(), id: "4", name: 'Petite voiture', quantity: 1, description: "Ceci est une Clio, c'est un beau cadeau pour une simple tombola quand même"),
      Lot(raffle: Raffle.empty(), id: "1", name: 'Aspernatur', quantity: 5, description: ""),
      Lot(raffle: Raffle.empty(), id: "2", name: 'Dolores', quantity: 3, description: null),
      Lot(raffle: Raffle.empty(), id: "3", name: 'Chaise de Jardin', quantity: 7, description: "dsdgftgfygukilgkyfutdstbrqefsrydxtufy"),
    ]);
  }

  Future<bool> addLot(Lot lot) async {
    return await add(_lotRepository.createLot, lot);
  }

  Future<bool> deleteLot(Lot lot) async {
    return await delete(
      _lotRepository.deleteLot,
      (lot, t) => lot..removeWhere((e) => e.id == t.id),
      lot.id,
      lot,
    );
  }

  Future<bool> updateLot(Lot lot) async {
    return await update(_lotRepository.updateLot,
        (lot, t) => lot..[lot.indexWhere((e) => e.id == t.id)] = t, lot);
  }
}

final lotListProvider =
    StateNotifierProvider<LotListNotifier, AsyncValue<List<Lot>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = LotListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    final raffleId = ref.watch(raffleIdProvider);
    if (raffleId != Raffle.empty().id) {
      notifier.setRaffleId(raffleId);
      notifier.loadLotList();
    }
  });
  return notifier;
});
