import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/repositories/scanner_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/user/class/simple_users.dart';

class ScannedUsersListNotifier extends ListNotifier<SimpleUser> {
  final ScannerRepository scannerRepository;
  AsyncValue<List<String>> tagList = const AsyncValue.loading();
  ScannedUsersListNotifier(this.scannerRepository)
    : super(const AsyncValue.loading());

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

final scannedUsersListProvider =
    StateNotifierProvider<
      ScannedUsersListNotifier,
      AsyncValue<List<SimpleUser>>
    >((ref) {
      final scannerRepository = ref.watch(scannerRepositoryProvider);
      ScannedUsersListNotifier notifier = ScannedUsersListNotifier(
        scannerRepository,
      );
      return notifier;
    });
