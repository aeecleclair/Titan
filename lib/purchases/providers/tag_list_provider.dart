import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository.dart';

class TagListNotifier extends ListNotifier2<String> {
  final Openapi scannerRepository;
  TagListNotifier({required this.scannerRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<String>>> loadTags(
    String sellerId,
    String productId,
    String generatorId,
  ) async {
    return await loadList(
      () => scannerRepository
          .cdrSellersSellerIdProductsProductIdTagsGeneratorIdGet(
        sellerId: sellerId,
        productId: productId,
        generatorId: generatorId,
      ),
    );
  }
}

final tagListProvider =
    StateNotifierProvider<TagListNotifier, AsyncValue<List<String>>>((ref) {
  final scannerRepository = ref.watch(repositoryProvider);
  TagListNotifier notifier =
      TagListNotifier(scannerRepository: scannerRepository);
  return notifier;
});
