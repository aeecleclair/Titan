import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/repositories/scanner_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class TagListNotifier extends ListNotifier<String> {
  final ScannerRepository scannerRepository;
  AsyncValue<List<String>> tagList = const AsyncValue.loading();
  TagListNotifier(this.scannerRepository) : super(const AsyncValue.loading());

  Future<AsyncValue<List<String>>> loadTags(
    String sellerId,
    String productId,
    String generatorId,
  ) async {
    return await loadList(
      () => scannerRepository.getTags(sellerId, productId, generatorId),
    );
  }
}

final tagListProvider =
    StateNotifierProvider<TagListNotifier, AsyncValue<List<String>>>((ref) {
      final scannerRepository = ref.watch(scannerRepositoryProvider);
      TagListNotifier notifier = TagListNotifier(scannerRepository);
      return notifier;
    });
