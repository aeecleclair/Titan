import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class CashProvider extends ListNotifier2<CashComplete> {
  final Openapi cashRepository;
  AsyncValue<List<CashComplete>> cashList = const AsyncLoading();
  CashProvider({required this.cashRepository}) : super(const AsyncLoading());

  Future<AsyncValue<List<CashComplete>>> loadCashList() async {
    return cashList = await loadList(cashRepository.tombolaUsersCashGet);
  }

  Future<bool> addCash(CashComplete cash) async {
    return await add(
        () => cashRepository.tombolaUsersUserIdCashPost(
            userId: cash.userId, body: CashEdit(balance: cash.balance)),
        cash);
  }

  Future<bool> updateCash(CashComplete cash, int amount) async {
    return await update(
      () => cashRepository.tombolaUsersUserIdCashPatch(
          userId: cash.userId, body: CashEdit(balance: amount.toDouble())),
      (cashList, c) => cashList
        ..[cashList.indexWhere((c) => c.user.id == cash.user.id)] =
            cash.copyWith(balance: cash.balance + amount),
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
    CashProvider cashProvider = CashProvider(cashRepository: cashRepository);
    tokenExpireWrapperAuth(ref, () async {
      await cashProvider.loadCashList();
    });
    return cashProvider;
  },
);
