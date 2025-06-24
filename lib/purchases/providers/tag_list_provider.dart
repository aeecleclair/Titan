import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/purchases/repositories/scanner_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class TagListNotifier extends ListNotifier<String> {
  final ScannerRepository scannerRepository = ScannerRepository();
  AsyncValue<List<String>> tagList = const AsyncValue.loading();
  TagListNotifier({required String token}) : super(const AsyncValue.loading()) {
    scannerRepository.setToken(token);
  }

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
      final token = ref.watch(tokenProvider);
      TagListNotifier notifier = TagListNotifier(token: token);
      return notifier;
    });
