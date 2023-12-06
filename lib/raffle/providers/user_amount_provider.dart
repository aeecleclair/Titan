import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserCashNotifier extends SingleNotifier2<AppSchemasSchemasRaffleCashComplete> {
  final Openapi cashRepository;
  UserCashNotifier({required this.cashRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<AppSchemasSchemasRaffleCashComplete>> loadCashByUser(String userId) async {
    return await load(() async => cashRepository.tombolaUsersUserIdCashGet(userId: userId));
  }

  Future updateCash(double amount) async {
    state.when(data: (cash) {
      final newCash = cash.copyWith(balance: cash.balance + amount);
      state = AsyncValue.data(newCash);
    }, error: (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }, loading: () {
      state = const AsyncValue.error(
          "Cannot update cash while loading", StackTrace.empty);
    });
  }
}

final userAmountProvider =
    StateNotifierProvider<UserCashNotifier, AsyncValue<AppSchemasSchemasRaffleCashComplete>>((ref) {
  final cashRepository = ref.watch(repositoryProvider);
  UserCashNotifier userCashNotifier = UserCashNotifier(cashRepository: cashRepository);
  tokenExpireWrapperAuth(ref, () async {
    final userId = ref.watch(idProvider);
    userId.whenData(
        (value) async => await userCashNotifier.loadCashByUser(value));
  });
  return userCashNotifier;
});
