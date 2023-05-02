import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/prize.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/providers/raffle_id_provider.dart';
import 'package:myecl/tombola/repositories/prizes_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class PrizeListNotifier extends ListNotifier<Prize> {
  final LotRepository _lotRepository = LotRepository();
  late String raffleId;
  PrizeListNotifier({required String token}) : super(const AsyncValue.loading()) {
    _lotRepository.setToken(token);
  }

  void setRaffleId(String id) {
    raffleId = id;
  }

  Future<AsyncValue<List<Prize>>> loadLotList() async {
    return await loadList(() async => _lotRepository.getLotList(raffleId));
  }

  Future<bool> addLot(Prize lot) async {
    return await add(_lotRepository.createLot, lot);
  }

  Future<bool> deleteLot(Prize lot) async {
    return await delete(
      _lotRepository.deletePrize,
      (lot, t) => lot..removeWhere((e) => e.id == t.id),
      lot.id,
      lot,
    );
  }

  Future<bool> updateLot(Prize lot) async {
    return await update(_lotRepository.updatePrize,
        (lot, t) => lot..[lot.indexWhere((e) => e.id == t.id)] = t, lot);
  }

  Future<bool> setLotToZeroQuantity(Prize lot) async {
    return await update((_) async => true,
        (lot, t) => lot..[lot.indexWhere((e) => e.id == t.id)] = t, lot);
  }
}

final prizeListProvider =
    StateNotifierProvider<PrizeListNotifier, AsyncValue<List<Prize>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = PrizeListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    final raffleId = ref.watch(raffleIdProvider);
    if (raffleId != Raffle.empty().id) {
      notifier.setRaffleId(raffleId);
      notifier.loadLotList();
    }
  });
  return notifier;
});
