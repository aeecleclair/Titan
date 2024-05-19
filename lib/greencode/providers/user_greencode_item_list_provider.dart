import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/greencode/class/greencode_item.dart';
import 'package:myecl/greencode/repositories/greencode_item_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserGreenCodeItemListNotifier extends ListNotifier<GreenCodeItem> {
  final GreenCodeItemRepository greencodeItemRepository;
  UserGreenCodeItemListNotifier({required this.greencodeItemRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<GreenCodeItem>>>
      loadCurrentUserGreenCodeItemList() async {
    return await loadList(greencodeItemRepository.getCurrentUserGreenCodeItems);
  }

  Future<bool> addCurrentUserToGreenCodeItem(
    GreenCodeItem greencodeItem,
  ) async {
    return await add(
      (GreenCodeItem item) async {
        await greencodeItemRepository.addCurrentUserToGreenCodeItem(item.id);
        return item;
      },
      greencodeItem,
    );
  }

  Future<bool> removeCurrentUserFromGreenCodeItem(
    GreenCodeItem greencodeItem,
  ) async {
    return delete(
      greencodeItemRepository.removeCurrentUserFromGreenCodeItem,
      (items, item) =>
          items..removeWhere((itemToCheck) => itemToCheck.id == item.id),
      greencodeItem.id,
      greencodeItem,
    );
  }
}

final greencodeItemListProvider = StateNotifierProvider<
    UserGreenCodeItemListNotifier, AsyncValue<List<GreenCodeItem>>>((ref) {
  final greencodeItemRepository = ref.watch(greencodeItemRepositoryProvider);
  final greencodeItemListNotifier = UserGreenCodeItemListNotifier(
    greencodeItemRepository: greencodeItemRepository,
  );
  tokenExpireWrapperAuth(ref, () async {
    await greencodeItemListNotifier.loadCurrentUserGreenCodeItemList();
  });
  return greencodeItemListNotifier;
});
