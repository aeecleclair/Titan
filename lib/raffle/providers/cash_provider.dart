import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/raffle/class/cash.dart';
import 'package:titan/raffle/repositories/cash_repository.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class CashProvider extends ListNotifier<Cash> {
  final CashRepository _cashRepository = CashRepository();
  AsyncValue<List<Cash>> _cashList = const AsyncLoading();
  CashProvider({required String token}) : super(const AsyncLoading()) {
    _cashRepository.setToken(token);
  }

  Future<AsyncValue<List<Cash>>> loadCashList() async {
    return _cashList = await loadList(_cashRepository.getCashList);
  }

  Future<bool> addCash(Cash cash) async {
    return await add(_cashRepository.createCash, cash);
  }

  Future<bool> updateCash(Cash cash, int amount) async {
    return await update(
      _cashRepository.updateCash,
      (cashList, c) => cashList
        ..[cashList.indexWhere((c) => c.user.id == cash.user.id)] = cash
            .copyWith(balance: cash.balance + amount),
      cash.copyWith(balance: amount.toDouble()),
    );
  }

  Future<AsyncValue<List<Cash>>> filterCashList(String filter) async {
    return state.when(
      data: (cashList) async {
        final lowerQuery = filter.toLowerCase();
        return state = AsyncData(
          cashList
              .where(
                (cash) =>
                    cash.user.name.toLowerCase().contains(lowerQuery) ||
                    cash.user.firstname.toLowerCase().contains(lowerQuery) ||
                    (cash.user.nickname != null &&
                        cash.user.nickname!.toLowerCase().contains(lowerQuery)),
              )
              .toList(),
        );
      },
      error: (error, stackTrace) {
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          return state;
        }
      },
      loading: () {
        return state;
      },
    );
  }

  Future<void> refreshCashList() async {
    state = _cashList;
  }
}

final cashProvider =
    StateNotifierProvider<CashProvider, AsyncValue<List<Cash>>>((ref) {
      final token = ref.watch(tokenProvider);
      CashProvider cashProvider = CashProvider(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await cashProvider.loadCashList();
      });
      return cashProvider;
    });
