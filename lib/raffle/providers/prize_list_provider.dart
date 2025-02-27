import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/raffle/providers/raffle_id_provider.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class PrizeListNotifier extends ListNotifier2<PrizeSimple> {
  final Openapi prizeRepository;
  PrizeListNotifier({required this.prizeRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<PrizeSimple>>> loadPrizeList(String raffleId) async {
    return await loadList(() async =>
        prizeRepository.tombolaRafflesRaffleIdPrizesGet(raffleId: raffleId));
  }

  Future<bool> addPrize(PrizeSimple prize) async {
    return await add(
        (prize) async => prizeRepository.tombolaPrizesPost(
                body: PrizeBase(
              name: prize.name,
              description: prize.description,
              raffleId: prize.raffleId,
              quantity: prize.quantity,
            )),
        prize);
  }

  Future<bool> deletePrize(PrizeSimple prize) async {
    return await delete(
      (prizeId) async =>
          prizeRepository.tombolaPrizesPrizeIdDelete(prizeId: prizeId),
      (prize, t) => prize..removeWhere((e) => e.id == t.id),
      prize.id,
      prize,
    );
  }

  Future<bool> updatePrize(PrizeSimple prize) async {
    return await update(
        (prize) async => prizeRepository.tombolaPrizesPrizeIdPatch(
            prizeId: prize.id,
            body: PrizeEdit(
              name: prize.name,
              description: prize.description,
              raffleId: prize.raffleId,
              quantity: prize.quantity,
            )),
        (prize, t) => prize..[prize.indexWhere((e) => e.id == t.id)] = t,
        prize);
  }

  Future<bool> setPrizeQuantityToZero(PrizeSimple prize) async {
    return state.when(data: (prizeList) async {
      final newPrize = prize.copyWith(quantity: 0);
      state = AsyncValue.data(prizeList
        ..[prizeList.indexWhere((e) => e.id == prize.id)] = newPrize);
      return true;
    }, error: (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return false;
    }, loading: () {
      state = const AsyncValue.error(
          "Cannot update prize while loading", StackTrace.empty);
      return false;
    });
  }
}

final prizeListProvider =
    StateNotifierProvider<PrizeListNotifier, AsyncValue<List<PrizeSimple>>>(
        (ref) {
  final prizeRepository = ref.watch(repositoryProvider);
  final notifier = PrizeListNotifier(prizeRepository: prizeRepository);
  tokenExpireWrapperAuth(ref, () async {
    final raffleId = ref.watch(raffleIdProvider);
    if (raffleId != RaffleComplete.fromJson({}).id) {
      notifier.loadPrizeList(raffleId);
    }
  });
  return notifier;
});
