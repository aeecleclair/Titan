import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/raffle/class/prize.dart';
import 'package:myecl/raffle/class/raffle.dart';
import 'package:myecl/raffle/providers/raffle_id_provider.dart';
import 'package:myecl/raffle/repositories/prize_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class LotListNotifier extends ListNotifier<Prize> {
  final LotRepository _lotRepository;
  late String raffleId;
  LotListNotifier(this._lotRepository) : super(const AsyncValue.loading());

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
      final lotRepository = ref.watch(lotRepositoryProvider);
      final notifier = LotListNotifier(lotRepository);
      tokenExpireWrapperAuth(ref, () async {
        final raffleId = ref.watch(raffleIdProvider);
        if (raffleId != Raffle.empty().id) {
          notifier.setRaffleId(raffleId);
          notifier.loadPrizeList();
        }
      });
      return notifier;
    });
