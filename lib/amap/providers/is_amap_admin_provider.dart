import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/rights.dart';
import 'package:myecl/amap/repositories/rights_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class RightNotifier extends SingleNotifier<Right> {
  final RightRepository _amapUserRepository = RightRepository();
  RightNotifier({required String token}) : super(const AsyncValue.loading()) {
    _amapUserRepository.setToken(token);
  }

  Future<AsyncValue<Right>> loadRights() async {
    return await load(_amapUserRepository.getRights);
  }
}

final rightProvider =
    StateNotifierProvider<RightNotifier, AsyncValue<Right>>((ref) {
  final token = ref.watch(tokenProvider);
  RightNotifier _rightNotifier = RightNotifier(token: token);
  _rightNotifier.loadRights();
  print('loaded');
  return _rightNotifier;
});

final amapId = StateProvider<String>((ref) {
  final rights = ref.watch(rightProvider);
  return rights.when(
      data: (right) => right.amapId,
      loading: () => "",
      error: (error, stackTrace) => "");
});

final isAmapAdmin = StateProvider<bool>((ref) {
  final rights = ref.watch(rightProvider);
  return rights.when(
      data: (right) => right.manage,
      loading: () => false,
      error: (error, stackTrace) => false);
});
