import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/raffle/class/prize.dart';
import 'package:titan/raffle/class/raffle.dart';
import 'package:titan/raffle/providers/raffle_id_provider.dart';
import 'package:titan/raffle/repositories/prize_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class LotListNotifier extends ListNotifier<Prize> {
  final LotRepository _lotRepository = LotRepository();
  late String raffleId;
  LotListNotifier({required String token}) : super(const AsyncValue.loading()) {
    _lotRepository.setToken(token);
  }

  void setRaffleId(String id) {
    raffleId = id;
  }

  Future<AsyncValue<List<Prize>>> loadPrizeList() async {
    return await loadList(() async => _lotRepository.getLotList(raffleId));
  }

  Future<bool> addPrize(Prize lot) async {
    return await add(_lotRepository.createLot, lot);
  }

  Future<bool> deletePrize(Prize lot) async {
    return await delete(
      _lotRepository.deleteLot,
      (lot, t) => lot..removeWhere((e) => e.id == t.id),
      lot.id,
      lot,
    );
  }

  Future<bool> updatePrize(Prize lot) async {
    return await update(
      _lotRepository.updateLot,
      (lot, t) => lot..[lot.indexWhere((e) => e.id == t.id)] = t,
      lot,
    );
  }

  Future<bool> setPrizeQuantityToZero(Prize lot) async {
    return await update(
      (_) async => true,
      (lot, t) => lot..[lot.indexWhere((e) => e.id == t.id)] = t,
      lot,
    );
  }
}

final prizeListProvider =
    StateNotifierProvider<LotListNotifier, AsyncValue<List<Prize>>>((ref) {
      final token = ref.watch(tokenProvider);
      final notifier = LotListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        final raffleId = ref.watch(raffleIdProvider);
        if (raffleId != Raffle.empty().id) {
          notifier.setRaffleId(raffleId);
          notifier.loadPrizeList();
        }
      });
      return notifier;
    });
