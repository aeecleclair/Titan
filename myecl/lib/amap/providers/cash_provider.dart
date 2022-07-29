import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/repositories/cash_repository.dart';

class CashProvider extends StateNotifier<AsyncValue<List<Cash>>> {
  final CashRepository _cashRepository = CashRepository();

  CashProvider() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Cash>>> loadCashList() async {
    try {
      final cashList = await _cashRepository.getCashList();
      state = AsyncValue.data(cashList);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<bool> addCash(Cash cash) async {
    return state.when(
      data: (cashList) async {
        try {
          await _cashRepository.createCash(cash, cash.user.id);
          cashList.add(cash);
          state = AsyncValue.data(cashList);
          return true;
        } catch (e) {
          state = AsyncValue.data(cashList);
          return false;
        }
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot add cash while loading");
        return false;
      },
    );
  }

  Future<bool> updateCash(Cash cash) async {
    return state.when(
      data: (cashList) async {
        try {
          await _cashRepository.updateCash(cash, cash.user.id);
          var index = cashList.indexWhere((p) => p.user.id == cash.user.id);
          cashList[index] = cash;
          state = AsyncValue.data(cashList);
          return true;
        } catch (e) {
          state = AsyncValue.data(cashList);
          return false;
        }
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot update cash while loading");
        return false;
      },
    );
  }
}


final cashProvider = StateNotifierProvider<CashProvider, AsyncValue<List<Cash>>>(
  (ref) {
    CashProvider _cashProvider = CashProvider();
    _cashProvider.loadCashList();
    return _cashProvider;
  },
);

