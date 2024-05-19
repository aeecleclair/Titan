import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/greencode/class/greencode_item.dart';
import 'package:myecl/greencode/repositories/greencode_item_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class GreenCodeItemNotifier extends SingleNotifier<GreenCodeItem> {
  final GreenCodeItemRepository greencodeItemRepository;
  GreenCodeItemNotifier({required this.greencodeItemRepository})
      : super(const AsyncLoading());

  void loadGreenCodeItembyQRCode(String qrCodeContent) async {
    state = const AsyncLoading();
    final item =
        await greencodeItemRepository.getGreenCodeItemByQR(qrCodeContent);
    state = AsyncData(item);
  }

  void setGreenCodeItem(GreenCodeItem i) {
    state = AsyncData(i);
  }
}

final greenCodeItemProvider =
    StateNotifierProvider<GreenCodeItemNotifier, AsyncValue<GreenCodeItem>>(
        (ref) {
  final greencodeItemRepository = ref.watch(greencodeItemRepositoryProvider);
  return GreenCodeItemNotifier(
    greencodeItemRepository: greencodeItemRepository,
  );
});
