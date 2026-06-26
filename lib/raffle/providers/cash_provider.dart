import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class CashProvider
    extends ListNotifierAPI<AppModulesRaffleSchemasRaffleCashComplete> {
  Openapi get cashRepository => ref.watch(repositoryProvider);
  AsyncValue<List<AppModulesRaffleSchemasRaffleCashComplete>> cashList =
      const AsyncLoading();

  @override
  AsyncValue<List<AppModulesRaffleSchemasRaffleCashComplete>> build() {
    loadCashList();
    return const AsyncLoading();
  }

  Future<AsyncValue<List<AppModulesRaffleSchemasRaffleCashComplete>>>
  loadCashList() async {
    return cashList = await loadList(cashRepository.tombolaUsersCashGet);
  }

  Future<bool> addCash(AppModulesRaffleSchemasRaffleCashComplete cash) async {
    return await add(
      () => cashRepository.tombolaUsersUserIdCashPost(
        userId: cash.userId,
        body: CashEdit(balance: cash.balance),
      ),
      cash,
    );
  }

  Future<bool> updateCash(
    AppModulesRaffleSchemasRaffleCashComplete cash,
    int amount,
  ) async {
    return await update(
      () => cashRepository.tombolaUsersUserIdCashPatch(
        userId: cash.userId,
        body: CashEdit(balance: amount.round()),
      ),
      (cash) => cash.userId,
      cash.copyWith(balance: amount.round()),
    );
  }

  Future<AsyncValue<List<AppModulesRaffleSchemasRaffleCashComplete>>>
  filterCashList(String filter) async {
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
    NotifierProvider<
      CashProvider,
      AsyncValue<List<AppModulesRaffleSchemasRaffleCashComplete>>
    >(() => CashProvider());
