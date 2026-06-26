import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class ScannedUsersListNotifier extends ListNotifierAPI<CoreUserSimple> {
  Openapi get scannerRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<CoreUserSimple>> build() {
    return const AsyncValue.loading();
  }

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

final scannedUsersListProvider =
    NotifierProvider<
      ScannedUsersListNotifier,
      AsyncValue<List<CoreUserSimple>>
    >(ScannedUsersListNotifier.new);
