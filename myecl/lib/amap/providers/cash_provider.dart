import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/repositories/cash_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/exception.dart';

class CashProvider extends StateNotifier<AsyncValue<List<Cash>>> {
  final CashRepository _cashRepository = CashRepository();

  CashProvider({required String token}) : super(const AsyncLoading()) {
    _cashRepository.setToken(token);
  }

  Future<AsyncValue<List<Cash>>> loadCashList() async {
    try {
      final cashList = await _cashRepository.getCashList();
      state = AsyncValue.data(cashList);
      return state;
    } catch (e) {
      state = AsyncValue.error(e);
      rethrow;
    }
  }

  Future<bool> addCash(Cash cash) async {
    return state.when(
      data: (cashList) async {
        try {
          Cash newCash = await _cashRepository.createCash(cash, cash.user.id);
          cashList.add(newCash);
          state = AsyncValue.data(cashList);
          return true;
        } catch (e) {
          state = AsyncValue.data(cashList);
          return false;
        }
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error);
        throw error as AppException;
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
        throw error as AppException;
      },
      loading: () {
        state = const AsyncValue.error("Cannot update cash while loading");
        return false;
      },
    );
  }

  Future<AsyncValue<List<Cash>>> filterCashList(String filter) async {
    return state.when(
      data: (cashList) async {
        final lowerQuery = filter.toLowerCase();
        return AsyncValue.data(cashList
            .where((cash) =>
                cash.user.name.toLowerCase().contains(lowerQuery) ||
                cash.user.firstname.toLowerCase().contains(lowerQuery) ||
                cash.user.nickname.toLowerCase().contains(lowerQuery))
            .toList());
      },
      error: (error, stackTrace) {
        throw error as AppException;
      },
      loading: () {
        return const AsyncValue.error("Cannot filter cash while loading");
      },
    );
  }
}

final cashProvider =
    StateNotifierProvider<CashProvider, AsyncValue<List<Cash>>>(
  (ref) {
    final token = ref.watch(tokenProvider);
    CashProvider _cashProvider = CashProvider(token: token);
    _cashProvider.loadCashList();
    return _cashProvider;
  },
);
