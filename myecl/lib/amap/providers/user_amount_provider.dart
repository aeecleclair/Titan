import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/repositories/amap_user_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/user/class/list_users.dart';

class UserCashNotifier extends StateNotifier<AsyncValue<Cash>> {
  final AmapUserRepository _amapUserRepository = AmapUserRepository();
  UserCashNotifier() : super(const AsyncValue.loading());

  Future<AsyncValue<Cash>> loadCashByUser(String userId) async {
    try {
      final amount = await _amapUserRepository.getCashByUser(userId);
      state = AsyncValue.data(amount);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
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
  UserCashNotifier _userCashNotifier = UserCashNotifier();
  final userId = ref.watch(idProvider);
  _userCashNotifier.loadCashByUser(userId);
  return _userCashNotifier;
});

