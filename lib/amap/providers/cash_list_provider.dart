import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/amap/adapters/cash.dart';

class CashListProvider extends ListNotifierAPI<CashComplete> {
  final Openapi cashRepository;
  AsyncValue<List<CashComplete>> _cashList = const AsyncLoading();
  CashListProvider({required this.cashRepository})
      : super(const AsyncLoading());

  Future<AsyncValue<List<CashComplete>>> loadCashList() async {
    return _cashList = await loadList(cashRepository.amapUsersCashGet);
  }

  Future<bool> addCash(CashComplete cash) async {
    return await add(
      () => cashRepository.amapUsersUserIdCashPost(
        userId: cash.user.id,
        body: cash.toCashEdit(),
      ),
      cash,
    );
  }

  Future<bool> updateCash(
    CashComplete addedCash,
    double previousCashAmount,
  ) async {
    return await update(
      () => cashRepository.amapUsersUserIdCashPatch(
        userId: addedCash.userId,
        body: addedCash.toCashEdit(),
      ),
      (cash) => cash.userId,
      addedCash.copyWith(
        balance: addedCash.balance + previousCashAmount,
      ),
    );
  }

  // To be changed
  Future<bool> fakeUpdateCash(CashComplete cash) async {
    return await localUpdate(
      (cash) => cash.userId,
      cash,
    );
  }

  Future<AsyncValue<List<CashComplete>>> filterCashList(String filter) async {
    state = _cashList.whenData(
      (cashList) {
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
      },
    );
    return state;
  }

  Future<void> refreshCashList() async {
    state = _cashList;
  }
}

final cashListProvider =
    StateNotifierProvider<CashListProvider, AsyncValue<List<CashComplete>>>(
  (ref) {
    final cashRepository = ref.watch(repositoryProvider);
    return CashListProvider(cashRepository: cashRepository)..loadCashList();
  },
);
