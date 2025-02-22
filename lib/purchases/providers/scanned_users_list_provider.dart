import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/purchases/repositories/scanner_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/user/class/simple_users.dart';

class ScannedUsersListNotifier extends ListNotifier<SimpleUser> {
  final ScannerRepository scannerRepository = ScannerRepository();
  AsyncValue<List<String>> tagList = const AsyncValue.loading();
  ScannedUsersListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    scannerRepository.setToken(token);
  }

  Future<AsyncValue<List<SimpleUser>>> loadUsers(
    String sellerId,
    String productId,
    String generatorId,
    String tag,
  ) async {
    return await loadList(
      () =>
          scannerRepository.getUsersList(sellerId, productId, generatorId, tag),
    );
  }
}

final scannedUsersListProvider = StateNotifierProvider<ScannedUsersListNotifier,
    AsyncValue<List<SimpleUser>>>((ref) {
  final token = ref.watch(tokenProvider);
  ScannedUsersListNotifier notifier = ScannedUsersListNotifier(token: token);
  return notifier;
});
