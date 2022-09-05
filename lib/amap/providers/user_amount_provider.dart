import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/repositories/amap_user_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

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
      state = AsyncValue.error(error);
    }, loading: () {
      state = const AsyncValue.error("Cannot update cash while loading");
    });
  }
}

final userAmountProvider =
    StateNotifierProvider<UserCashNotifier, AsyncValue<Cash>>((ref) {
  final token = ref.watch(tokenProvider);
  UserCashNotifier _userCashNotifier = UserCashNotifier(token: token);
  final userId = ref.watch(idProvider);
  _userCashNotifier.loadCashByUser(userId);
  return _userCashNotifier;
});
