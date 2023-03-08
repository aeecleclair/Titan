import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/repositories/lots_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class LotListNotifier extends ListNotifier<Lot> {
  final LotRepository _lotRepository = LotRepository();
  LotListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _lotRepository.setToken(token);
  }

  Future<AsyncValue<List<Lot>>> loadLotList(
      String raffleId) async {
    // return await loadList(
    //     () async => _lotRepository.getLotList(raffleId));
    return state = AsyncData([
      Lot(raffleId: "1", id: "1", description: 'aspernatur', quantity: 5),
      Lot(raffleId: "1", id: "2", description: 'dolores', quantity: 3),
      Lot(raffleId: "1", id: "3", description: 'fugit', quantity: 7),
    ]);
  }

  Future<bool> addLot(Lot lot) async {
    return add(_lotRepository.createLot, lot);
  }

  Future<bool> deleteLot(Lot lot) async {
    return delete(
      _lotRepository.deleteLot,
      (lot, t) =>
          lot..removeWhere((e) => e.id == t.id),
      "TODO",
      lot,
    );
  }

  Future<bool> updateLot(Lot lot) async {
    return update(
        _lotRepository.updateLot,
        (lot, t) => lot
          ..[lot.indexWhere((e) => e.id == t.id)] = t,
        lot);
  }
}

final lotListProvider = StateNotifierProvider<LotListNotifier,
    AsyncValue<List<Lot>>>((ref) {
  final token = ref.watch(tokenProvider);
  return LotListNotifier(token: token);
});
