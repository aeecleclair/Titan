import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/raffle/adapters/prize.dart';

class PrizeListNotifier extends ListNotifierAPI<PrizeSimple> {
  final Openapi prizeRepository;
  PrizeListNotifier({required this.prizeRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<PrizeSimple>>> loadPrizeList(String raffleId) async {
    return await loadList(() async =>
        prizeRepository.tombolaRafflesRaffleIdPrizesGet(raffleId: raffleId));
  }

  Future<bool> addPrize(PrizeBase prize) async {
    return await add(
        () => prizeRepository.tombolaPrizesPost(body: prize), prize);
  }

  Future<bool> updatePrize(PrizeSimple prize) async {
    return await update(
      () => prizeRepository.tombolaPrizesPrizeIdPatch(
        prizeId: prize.id,
        body: prize.toPrizeEdit(),
      ),
      (prize) => prize.id,
      prize,
    );
  }

  Future<bool> deletePrize(PrizeSimple prize) async {
    return await delete(
      () => prizeRepository.tombolaPrizesPrizeIdDelete(prizeId: prize.id),
      (p) => p.id,
      prize.id,
    );
  }

  Future<bool> setPrizeQuantityToZero(PrizeSimple prize) async {
    return await localUpdate(
      (prize) => prize.id,
      prize,
    );
  }
}

final prizeListProvider = StateNotifierProvider.family<PrizeListNotifier,
    AsyncValue<List<PrizeSimple>>, String>((ref, raffleId) {
  final prizeRepository = ref.watch(repositoryProvider);
  final notifier = PrizeListNotifier(prizeRepository: prizeRepository);
  tokenExpireWrapperAuth(ref, () async {
    notifier.loadPrizeList(raffleId);
  });
  return notifier;
});
