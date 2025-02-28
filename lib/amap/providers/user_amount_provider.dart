import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserCashNotifier extends SingleNotifier2<CashComplete> {
  final Openapi amapUserRepository;
  UserCashNotifier({required this.amapUserRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<CashComplete>> loadCashByUser(String userId) async {
    return await load(
      () async => amapUserRepository.amapUsersUserIdCashGet(userId: userId),
    );
  }

  Future updateCash(double amount) async {
    state.when(
      data: (cash) {
        final newCash = cash.copyWith(balance: cash.balance + amount);
        state = AsyncValue.data(newCash);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
      loading: () {
        state = const AsyncValue.error(
          "Cannot update cash while loading",
          StackTrace.empty,
        );
      },
    );
  }
}

final userAmountProvider =
    StateNotifierProvider<UserCashNotifier, AsyncValue<CashComplete>>((ref) {
  final amapUserRepository = ref.watch(repositoryProvider);
  UserCashNotifier userCashNotifier =
      UserCashNotifier(amapUserRepository: amapUserRepository);
  tokenExpireWrapperAuth(ref, () async {
    final userId = ref.watch(idProvider);
    userId.whenData(
      (value) async => await userCashNotifier.loadCashByUser(value),
    );
  });
  return userCashNotifier;
});
