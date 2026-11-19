import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/greencode/class/greencode_item.dart';
import 'package:myecl/greencode/repositories/greencode_item_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AllGreenCodeItemListNotifier extends ListNotifier<GreenCodeItem> {
  final GreenCodeItemRepository greencodeItemRepository;
  AllGreenCodeItemListNotifier({required this.greencodeItemRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<GreenCodeItem>>> loadGreenCodeItemList() async {
    return await loadList(greencodeItemRepository.getAllGreenCodeItems);
  }

  Future<bool> addGreenCodeItem(GreenCodeItem greencodeItem) async {
    return await add(greencodeItemRepository.addGreenCodeItem, greencodeItem);
  }

  Future<bool> updateGreenCodeItem(GreenCodeItem greencodeItem) async {
    return await update(
      greencodeItemRepository.updateGreenCodeItem,
      (greencodeItems, greencodeItem) => greencodeItems
        ..[greencodeItems.indexWhere((item) => item.id == greencodeItem.id)] =
            greencodeItem,
      greencodeItem,
    );
  }

  Future<bool> deleteGreenCodeItem(GreenCodeItem greencodeItem) async {
    return await delete(
      greencodeItemRepository.deleteGreenCodeItem,
      (greencodeItems, greencodeItem) =>
          greencodeItems..removeWhere((item) => item.id == greencodeItem.id),
      greencodeItem.id,
      greencodeItem,
    );
  }
}

final greencodeItemListProvider = StateNotifierProvider<
    AllGreenCodeItemListNotifier, AsyncValue<List<GreenCodeItem>>>((ref) {
  final greencodeItemRepository = ref.watch(greencodeItemRepositoryProvider);
  final greencodeItemListNotifier = AllGreenCodeItemListNotifier(
    greencodeItemRepository: greencodeItemRepository,
  );
  tokenExpireWrapperAuth(ref, () async {
    await greencodeItemListNotifier.loadGreenCodeItemList();
  });
  return greencodeItemListNotifier;
});
