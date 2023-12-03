import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/client_index.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ItemListNotifier extends ListNotifier2<Item> {
  final Openapi itemRepository;
  ItemListNotifier({required this.itemRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Item>>> loadItemList(String id) async {
    return await loadList(
        () async => itemRepository.loansLoanersLoanerIdItemsGet(loanerId: id));
  }

  Future<bool> addItem(Item item, String loanerId) async {
    return await add(
        (item) async => itemRepository.loansLoanersLoanerIdItemsPost(
            loanerId: loanerId,
            body: ItemBase(
              name: item.name,
              suggestedCaution: item.suggestedCaution,
              totalQuantity: item.totalQuantity,
              suggestedLendingDuration: item.suggestedLendingDuration,
            )),
        item);
  }

  Future<bool> updateItem(Item item, String loanerId) async {
    return await update(
        (item) async => itemRepository.loansLoanersLoanerIdItemsItemIdPatch(
            loanerId: loanerId,
            itemId: item.id,
            body: ItemUpdate(
              name: item.name,
              suggestedCaution: item.suggestedCaution,
              totalQuantity: item.totalQuantity,
              suggestedLendingDuration: item.suggestedLendingDuration,
            )),
        (items, item) =>
            items..[items.indexWhere((i) => i.id == item.id)] = item,
        item);
  }

  Future<bool> deleteItem(Item item, String loanerId) async {
    return await delete(
        (itemId) async => itemRepository.loansLoanersLoanerIdItemsItemIdDelete(
            loanerId: loanerId, itemId: itemId),
        (items, item) => items..removeWhere((i) => i.id == item.id),
        item.id,
        item);
  }

  Future<AsyncValue<List<Item>>> copy() async {
    return state.whenData((d) => d.sublist(0));
  }

  Future<AsyncValue<List<Item>>> filterItems(String query) async {
    return state.whenData((items) => items
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList());
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
