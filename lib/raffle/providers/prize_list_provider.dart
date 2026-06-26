import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/raffle/providers/raffle_id_provider.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class LotListNotifier extends ListNotifierAPI<PrizeSimple> {
  Openapi get prizeRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<PrizeSimple>> build() {
    final raffleIdValue = ref.watch(raffleIdProvider);
    if (raffleIdValue != PrizeSimple.empty().id) {
      loadPrizeList(raffleIdValue);
    }
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<PrizeSimple>>> loadPrizeList(String raffleId) async {
    return await loadList(
      () async =>
          prizeRepository.tombolaRafflesRaffleIdPrizesGet(raffleId: raffleId),
    );
  }

  Future<bool> addPrize(PrizeBase prize) async {
    return await add(
      () => prizeRepository.tombolaPrizesPost(body: prize),
      prize,
    );
  }

  Future<bool> updatePrize(PrizeSimple prize) async {
    return await update(
      () => prizeRepository.tombolaPrizesPrizeIdPatch(
        prizeId: prize.id,
        body: PrizeEdit(
          raffleId: prize.raffleId,
          description: prize.description,
          name: prize.name,
          quantity: prize.quantity,
        ),
      ),
      (prize) => prize.id,
      prize,
    );
  }

  Future<bool> deletePrize(PrizeSimple prize) async {
    return await delete(
      () => prizeRepository.tombolaPrizesPrizeIdDelete(prizeId: prize.id),
      (prize) => prize.id,
      prize.id,
    );
  }

  Future<bool> setPrizeQuantityToZero(PrizeSimple prize) async {
    return await localUpdate((prize) => prize.id, prize.copyWith(quantity: 0));
  }
}

final prizeListProvider =
    NotifierProvider<LotListNotifier, AsyncValue<List<PrizeSimple>>>(
      LotListNotifier.new,
    );
