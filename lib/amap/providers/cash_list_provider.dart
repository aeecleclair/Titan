import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class CashListProvider
    extends ListNotifierAPI<AppModulesAmapSchemasAmapCashComplete> {
  Openapi get cashRepository => ref.watch(repositoryProvider);
  AsyncValue<List<AppModulesAmapSchemasAmapCashComplete>> _cashList =
      const AsyncLoading();

  @override
  AsyncValue<List<AppModulesAmapSchemasAmapCashComplete>> build() {
    loadCashList();
    return const AsyncLoading();
  }

  Future<AsyncValue<List<AppModulesAmapSchemasAmapCashComplete>>>
  loadCashList() async {
    return _cashList = await loadList(cashRepository.amapUsersCashGet);
  }

  Future<bool> addCash(AppModulesAmapSchemasAmapCashComplete cash) async {
    return await add(
      () => cashRepository.amapUsersUserIdCashPost(
        userId: cash.user.id,
        body: CashEdit(balance: cash.balance),
      ),
      cash,
    );
  }

  Future<bool> updateCash(
    AppModulesAmapSchemasAmapCashComplete addedCash,
    double previousCashAmount,
  ) async {
    return await update(
      () => cashRepository.amapUsersUserIdCashPatch(
        userId: addedCash.userId,
        body: CashEdit(balance: addedCash.balance),
      ),
      (cash) => cash.userId,
      addedCash,
    );
  }

  Future<bool> fakeUpdateCash(
    AppModulesAmapSchemasAmapCashComplete cash,
  ) async {
    return await localUpdate((cash) => cash.userId, cash);
  }

  Future<AsyncValue<List<AppModulesAmapSchemasAmapCashComplete>>>
  filterCashList(String filter) async {
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
    NotifierProvider<
      CashListProvider,
      AsyncValue<List<AppModulesAmapSchemasAmapCashComplete>>
    >(CashListProvider.new);
