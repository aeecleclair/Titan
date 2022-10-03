import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/repositories/cash_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class CashProvider extends ListNotifier<Cash> {
  final CashRepository _cashRepository = CashRepository();

  CashProvider({required String token}) : super(const AsyncLoading()) {
    _cashRepository.setToken(token);
  }

  Future<AsyncValue<List<Cash>>> loadCashList() async {
    return await loadList(_cashRepository.getCashList);
  }

  Future<bool> addCash(Cash cash) async {
    return await add(_cashRepository.createCash, cash);
  }

  Future<bool> updateCash(Cash cash) async {
    return await update(
        _cashRepository.updateCash,
        (cashs, cash) =>
            cashs..[cashs.indexWhere((c) => c.user.id == cash.user.id)] = cash,
        cash);
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
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          return AsyncValue.error(error);
        }
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
    CashProvider cashProvider = CashProvider(token: token);
    cashProvider.loadCashList();
    return cashProvider;
  },
);
