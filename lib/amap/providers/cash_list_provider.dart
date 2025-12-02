import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/class/cash.dart';
import 'package:titan/amap/repositories/cash_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class CashListProvider extends ListNotifier<Cash> {
  final CashRepository cashRepository;
  AsyncValue<List<Cash>> _cashList = const AsyncLoading();
  CashListProvider({required this.cashRepository})
    : super(const AsyncLoading());

  Future<AsyncValue<List<Cash>>> loadCashList() async {
    return _cashList = await loadList(cashRepository.getCashList);
  }

  Future<bool> addCash(Cash cash) async {
    return await add(cashRepository.createCash, cash);
  }

  Future<bool> updateCash(Cash addedCash, int previousCashAmount) async {
    return await update(
      cashRepository.updateCash,
      (cashList, c) => cashList
        ..[cashList.indexWhere((c) => c.user.id == addedCash.user.id)] =
            addedCash.copyWith(balance: addedCash.balance + previousCashAmount),
      addedCash,
    );
  }

  Future<bool> fakeUpdateCash(Cash cash) async {
    return await update(
      (_) async => true,
      (cashList, c) =>
          cashList
            ..[cashList.indexWhere((c) => c.user.id == cash.user.id)] = cash,
      cash,
    );
  }

  Future<AsyncValue<List<Cash>>> filterCashList(String filter) async {
    state = _cashList.whenData((cashList) {
      final lowerQuery = filter.toLowerCase();
      return cashList
          .where(
            (cash) =>
                cash.user.name.toLowerCase().contains(lowerQuery) ||
                cash.user.firstname.toLowerCase().contains(lowerQuery) ||
                (cash.user.nickname != null &&
                    cash.user.nickname!.toLowerCase().contains(lowerQuery)),
          )
          .toList();
    });
    return state;
  }

  Future<void> refreshCashList() async {
    state = _cashList;
  }
}

final cashListProvider =
    StateNotifierProvider<CashListProvider, AsyncValue<List<Cash>>>((ref) {
      final cashRepository = ref.watch(cashRepositoryProvider);
      CashListProvider cashListProvider = CashListProvider(
        cashRepository: cashRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await cashListProvider.loadCashList();
      });
      return cashListProvider;
    });
