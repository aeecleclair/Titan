import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class UserCashNotifier
    extends SingleNotifierAPI<AppModulesAmapSchemasAmapCashComplete> {
  Openapi get amapUserRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<AppModulesAmapSchemasAmapCashComplete> build() {
    final userId = ref.watch(idProvider);
    userId.whenData((value) async => await loadCashByUser(value));
    return state;
  }

  Future<AsyncValue<AppModulesAmapSchemasAmapCashComplete>> loadCashByUser(
    String userId,
  ) async {
    return await load(
      () async => amapUserRepository.amapUsersUserIdCashGet(userId: userId),
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
      AsyncValue<AppModulesAmapSchemasAmapCashComplete>
    >(UserCashNotifier.new);
