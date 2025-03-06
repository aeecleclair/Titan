import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/raffle/adapters/cash.dart';

class CashProvider extends ListNotifierAPI<CashComplete> {
  final Openapi cashRepository;
  AsyncValue<List<CashComplete>> cashList = const AsyncLoading();
  CashProvider({required this.cashRepository}) : super(const AsyncLoading());

  Future<AsyncValue<List<CashComplete>>> loadCashList() async {
    return cashList = await loadList(cashRepository.tombolaUsersCashGet);
  }

  Future<bool> addCash(CashComplete cash) async {
    return await add(
      () => cashRepository.tombolaUsersUserIdCashPost(
        userId: cash.userId,
        body: cash.toCashEdit(),
      ),
      cash,
    );
  }

  Future<bool> updateCash(CashComplete cash, int amount) async {
    return await update(
      () => cashRepository.tombolaUsersUserIdCashPatch(
        userId: cash.userId,
        body: cash.toCashEditWithAmount(amount.toDouble()),
      ),
      (cash) => cash.userId,
      cash.copyWith(balance: amount.toDouble()),
    );
  }

  Future<AsyncValue<List<CashComplete>>> filterCashList(String filter) async {
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
    state = cashList;
  }
}

final cashProvider =
    StateNotifierProvider<CashProvider, AsyncValue<List<CashComplete>>>(
  (ref) {
    final cashRepository = ref.watch(repositoryProvider);
    return CashProvider(cashRepository: cashRepository)..loadCashList();
  },
);
