import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class TagListNotifier extends ListNotifierAPI<String> {
  Openapi get scannerRepository => ref.watch(repositoryProvider);
  AsyncValue<List<String>> tagList = const AsyncValue.loading();

  @override
  AsyncValue<List<String>> build() {
    return const AsyncValue.loading();
  }

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
    NotifierProvider<TagListNotifier, AsyncValue<List<String>>>(
      TagListNotifier.new,
    );
