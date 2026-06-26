import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/user/providers/user_provider.dart';

class UserCashNotifier
    extends SingleNotifierAPI<AppModulesRaffleSchemasRaffleCashComplete> {
  Openapi get cashRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<AppModulesRaffleSchemasRaffleCashComplete> build() {
    final user = ref.watch(userProvider);
    loadCashByUser(user.id);
    return const AsyncValue.loading();
  }

  Future<AsyncValue<AppModulesRaffleSchemasRaffleCashComplete>> loadCashByUser(
    String userId,
  ) async {
    return await load(
      () async => cashRepository.tombolaUsersUserIdCashGet(userId: userId),
    );
  }

  Future updateCash(double amount) async {
    state.when(
      data: (cash) {
        final newCash = cash.copyWith(balance: (cash.balance + amount).round());
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
    NotifierProvider<
      UserCashNotifier,
      AsyncValue<AppModulesRaffleSchemasRaffleCashComplete>
    >(UserCashNotifier.new);
