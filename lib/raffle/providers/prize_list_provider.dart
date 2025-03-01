import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class PrizeListNotifier extends ListNotifier2<PrizeSimple> {
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
          body: PrizeEdit(
            raffleId: prize.raffleId,
            description: prize.description,
            name: prize.name,
            quantity: prize.quantity,
          )),
      (prize, t) => prize..[prize.indexWhere((e) => e.id == t.id)] = t,
      prize,
    );
  }

  Future<bool> deletePrize(PrizeSimple prize) async {
    return await delete(
      () => prizeRepository.tombolaPrizesPrizeIdDelete(prizeId: prize.id),
      (prize, t) => prize..removeWhere((e) => e.id == t.id),
      prize,
    );
  }

  Future<bool> setPrizeQuantityToZero(PrizeSimple prize) async {
    return await localUpdate(
      (prize, t) => prize..[prize.indexWhere((e) => e.id == t.id)] = t,
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
