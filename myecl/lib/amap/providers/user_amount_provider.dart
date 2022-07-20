import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/repositories/amap_user_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';

class UserCashNotifier extends StateNotifier<AsyncValue<double>> {
  final AmapUserRepository _amapUserRepository = AmapUserRepository();
  UserCashNotifier() : super(const AsyncValue.loading());

  Future<AsyncValue<double>> loadCashByUser(String userId) async {
    try {
      final deliveriesList = await _amapUserRepository.getCashByUser(userId);
      state = AsyncValue.data(deliveriesList);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }
}

final userAmountProvider =
    StateNotifierProvider<UserCashNotifier, AsyncValue<double>>((ref) {
  UserCashNotifier _userCashNotifier = UserCashNotifier();
  final userId = ref.watch(idProvider);
  _userCashNotifier.loadCashByUser(userId);
  return _userCashNotifier;
});

final userCashProvider = Provider((ref) {
  final userAmount = ref.watch(userAmountProvider);
  return userAmount.when(data: (amount) {
    return amount;
  }, error: (error, stackTrace) {
    return 0;
  }, loading: () {
    return 0;
  });
});
