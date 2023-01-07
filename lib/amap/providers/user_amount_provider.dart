import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/repositories/amap_user_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserCashNotifier extends SingleNotifier<Cash> {
  final AmapUserRepository _amapUserRepository = AmapUserRepository();
  UserCashNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _amapUserRepository.setToken(token);
  }

  Future<AsyncValue<Cash>> loadCashByUser(String userId) async {
    return await load(() async => _amapUserRepository.getCashByUser(userId));
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
    StateNotifierProvider<UserCashNotifier, AsyncValue<Cash>>((ref) {
  final token = ref.watch(tokenProvider);
  UserCashNotifier userCashNotifier = UserCashNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    final userId = ref.watch(idProvider);
    await userCashNotifier.loadCashByUser(userId);
  });
  return userCashNotifier;
});
