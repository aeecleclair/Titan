import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ItemListNotifier extends ListNotifier2<Item> {
  final Openapi itemRepository;
  ItemListNotifier({required this.itemRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Item>>> loadItemList(String loanerId) async {
    return await loadList(() async =>
        itemRepository.loansLoanersLoanerIdItemsGet(loanerId: loanerId));
  }

  Future<bool> addItem(ItemBase item, String loanerId) async {
    return await add(
        () async => itemRepository.loansLoanersLoanerIdItemsPost(
            loanerId: loanerId, body: item),
        item);
  }

  Future<bool> updateItem(Item item, String loanerId) async {
    return await update(
      () async => itemRepository.loansLoanersLoanerIdItemsItemIdPatch(
          loanerId: loanerId,
          itemId: item.id,
          body: ItemUpdate(
              name: item.name,
              suggestedCaution: item.suggestedCaution,
              totalQuantity: item.totalQuantity,
              suggestedLendingDuration: item.suggestedLendingDuration)),
      (items, item) => items..[items.indexWhere((i) => i.id == item.id)] = item,
      item,
    );
  }

  Future<bool> deleteItem(Item item, String loanerId) async {
    return await delete(
      () async => itemRepository.loansLoanersLoanerIdItemsItemIdDelete(
          loanerId: loanerId, itemId: item.id),
      (items, item) => items..removeWhere((i) => i.id == item.id),
      item,
    );
  }

  Future<AsyncValue<List<Item>>> copy() async {
    return state.whenData((d) => d.sublist(0));
  }

  Future<AsyncValue<List<Item>>> filterItems(String query) async {
    return state.whenData(
      (items) => items
          .where(
            (item) => item.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList(),
    );
  }
}

final itemListProvider =
    StateNotifierProvider<ItemListNotifier, AsyncValue<List<Item>>>((ref) {
  final itemRepository = ref.watch(repositoryProvider);
  ItemListNotifier itemListNotifier =
      ItemListNotifier(itemRepository: itemRepository);
  tokenExpireWrapperAuth(ref, () async {
    final loanerId = ref.watch(loanerIdProvider);
    if (loanerId != "") {
      await itemListNotifier.loadItemList(loanerId);
    }
  });
  return itemListNotifier;
});
