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
  UserCashNotifier _orderListNotifier = UserCashNotifier();
  final userId = ref.read(idProvider);
  _orderListNotifier.loadCashByUser(userId);
  return _orderListNotifier;
});
