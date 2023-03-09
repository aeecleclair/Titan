import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/lots.dart';
import 'package:myecl/tombola/repositories/lots_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class LotsListNotifier extends ListNotifier<Lot> {
  final LotRepository _lotsRepository = LotRepository();
  LotsListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _lotsRepository.setToken(token);
  }

  Future<AsyncValue<List<Lot>>> loadLotsList(
      String raffleId) async {
    // return await loadList(
    //     () async => _LotsRepository.getLotsList(raffleId));
    return state = AsyncData([
      Lot(raffleId: "1", id: "1", description: 'maison', quantity: 1),
      Lot(raffleId: "1", id: "2", description: 'ordinateur', quantity: 5),
      Lot(raffleId: "1", id: "3", description: 'Chaise de jardins avec tables', quantity: 5),
      Lot(raffleId: "2", id: "4", description: 'maison', quantity: 1),

    ]);
  }

  Future<bool> addLot(Lot Lot) async {
    return add(_lotsRepository.createLot, Lot);
  }
  // Il reste deleteLot et updateLot

}

final lotsListProvider = StateNotifierProvider<LotsListNotifier,
    AsyncValue<List<Lot>>>((ref) {
  final token = ref.watch(tokenProvider);
  return LotsListNotifier(token: token);
});
