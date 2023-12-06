import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class CashListProvider
    extends ListNotifier2<AppSchemasSchemasAmapCashComplete> {
  final Openapi cashRepository;
  AsyncValue<List<AppSchemasSchemasAmapCashComplete>> _cashList =
      const AsyncLoading();
  CashListProvider({required this.cashRepository})
      : super(const AsyncLoading());

  Future<AsyncValue<List<AppSchemasSchemasAmapCashComplete>>>
      loadCashList() async {
    return _cashList = await loadList(cashRepository.amapUsersCashGet);
  }

  Future<bool> addCash(AppSchemasSchemasAmapCashComplete cash) async {
    return await add(
        (cash) async => cashRepository.amapUsersUserIdCashPost(
            userId: cash.userId,
            body: AppSchemasSchemasAmapCashEdit(balance: cash.balance)),
        cash);
  }

  Future<bool> updateCash(
      AppSchemasSchemasAmapCashComplete cash, double amount) async {
    return await update(
        (cash) async => cashRepository.amapUsersUserIdCashPatch(
            userId: cash.userId,
            body: AppSchemasSchemasAmapCashEdit(
              balance: cash.balance,
            )),
        (cashList, c) => cashList
          ..[cashList.indexWhere((c) => c.user.id == cash.user.id)] =
              cash.copyWith(balance: cash.balance + amount),
        cash);
  }

  Future<AsyncValue<List<AppSchemasSchemasAmapCashComplete>>> filterCashList(
      String filter) async {
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

final cashListProvider = StateNotifierProvider<CashListProvider,
    AsyncValue<List<AppSchemasSchemasAmapCashComplete>>>(
  (ref) {
    final cashRepository = ref.watch(repositoryProvider);
    CashListProvider cashListProvider =
        CashListProvider(cashRepository: cashRepository);
    tokenExpireWrapperAuth(ref, () async {
      await cashListProvider.loadCashList();
    });
    return cashListProvider;
  },
);
