import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/raffle/class/cash.dart';
import 'package:myecl/raffle/repositories/cash_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class UserCashNotifier extends SingleNotifier<Cash> {
  final CashRepository _cashRepository;
  UserCashNotifier(this._cashRepository) : super(const AsyncValue.loading());

  Future<AsyncValue<Cash>> loadCashByUser(String userId) async {
    return await load(() async => _cashRepository.getCash(userId));
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
    StateNotifierProvider<UserCashNotifier, AsyncValue<Cash>>((ref) {
      final cashRepository = ref.watch(cashRepositoryProvider);
      UserCashNotifier userCashNotifier = UserCashNotifier(cashRepository);
      final userId = ref.watch(userIdProvider);
      userId.whenData((value) async => userCashNotifier.loadCashByUser(value));
      return userCashNotifier;
    });
