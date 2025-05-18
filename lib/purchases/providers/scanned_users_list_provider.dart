import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class ScannedUsersListNotifier extends ListNotifierAPI<CoreUserSimple> {
  final Openapi scannerRepository;
  ScannedUsersListNotifier({required this.scannerRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<CoreUserSimple>>> loadUsers(
    String sellerId,
    String productId,
    String generatorId,
    String tag,
  ) async {
    return await loadList(
      () => scannerRepository
          .cdrSellersSellerIdProductsProductIdTicketsGeneratorIdListsTagGet(
        sellerId: sellerId,
        productId: productId,
        generatorId: generatorId,
        tag: tag,
      ),
    );
  }
}

final scannedUsersListProvider = StateNotifierProvider<ScannedUsersListNotifier,
    AsyncValue<List<CoreUserSimple>>>((ref) {
  final scannerRepository = ref.watch(repositoryProvider);
  ScannedUsersListNotifier notifier =
      ScannedUsersListNotifier(scannerRepository: scannerRepository);
  return notifier;
});
