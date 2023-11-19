import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/repositories/cash_repository.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

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

  Future<bool> updateCash(Cash cash, double amount) async {
    return await update(
        cashRepository.updateCash,
        (cashList, c) => cashList
          ..[cashList.indexWhere((c) => c.user.id == cash.user.id)] =
              cash.copyWith(balance: cash.balance + amount),
        cash);
  }

  Future<bool> fakeUpdateCash(Cash cash) async {
    return await update(
        (_) async => true,
        (cashList, c) => cashList
          ..[cashList.indexWhere((c) => c.user.id == cash.user.id)] = cash,
        cash);
  }

  Future<AsyncValue<List<Cash>>> filterCashList(String filter) async {
    return state.when(
      data: (cashList) async {
        final lowerQuery = filter.toLowerCase();
        return state = AsyncData(cashList
            .where((cash) =>
                cash.user.name.toLowerCase().contains(lowerQuery) ||
                cash.user.firstname.toLowerCase().contains(lowerQuery) ||
                (cash.user.nickname != null &&
                    cash.user.nickname!.toLowerCase().contains(lowerQuery)))
            .toList());
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

final cashListProvider =
    StateNotifierProvider<CashListProvider, AsyncValue<List<Cash>>>(
  (ref) {
    final cashRepository = ref.watch(cashRepositoryProvider);
    CashListProvider cashListProvider =
        CashListProvider(cashRepository: cashRepository);
    tokenExpireWrapperAuth(ref, () async {
      await cashListProvider.loadCashList();
    });
    return cashListProvider;
  },
);
