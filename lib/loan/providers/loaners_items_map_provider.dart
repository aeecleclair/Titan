import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/item_quantity.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class LoanersItemsMapNotifier extends MapNotifier<String, Item> {
  LoanersItemsMapNotifier() : super();

  void addItemForLoaner(
    Loaner loaner,
    Item item,
  ) {
    return state[loaner.id]!.maybeWhen(
      data: (itemList) {
        itemList.add(item);
        state[loaner.id] = AsyncValue.data(itemList);
        state = Map.of(state);
      },
      orElse: () {},
    );
  }

  void updateItemForLoaner(
    Loaner loaner,
    Item item,
  ) {
    return state[loaner.id]!.maybeWhen(
      data: (itemList) {
        itemList[itemList
            .indexWhere((itemToTest) => item.id == itemToTest.id)] = item;
        state[loaner.id] = AsyncValue.data(itemList);
        state = Map.of(state);
      },
      orElse: () {},
    );
  }

  void updateItemsFromLoanReturnForLoaner(
    Loaner loaner,
    List<ItemQuantity> itemQuantities,
  ) {
    return state[loaner.id]!.maybeWhen(
      data: (itemList) {
        for (var itemQuantity in itemQuantities) {
          int itemIndex = itemList
              .indexWhere((item) => item.id == itemQuantity.itemSimple.id);
          itemList[itemIndex] = itemList[itemIndex].copyWith(
            loanedQuantity:
                itemList[itemIndex].loanedQuantity - itemQuantity.quantity,
          );
        }
        state[loaner.id] = AsyncValue.data(itemList);
        state = Map.of(state);
      },
      orElse: () {},
    );
  }

  void removeItemForLoaner(Loaner loaner, Item item) {
    return state[loaner.id]!.maybeWhen(
      data: (itemList) {
        itemList.where(
          (itemToTest) => itemToTest.id != item.id,
        );
        state[loaner.id] = AsyncValue.data(itemList);
        state = Map.of(state);
      },
      orElse: () {},
    );
  }
}

final loanersItemsMapProvider = StateNotifierProvider<LoanersItemsMapNotifier,
    Map<String, AsyncValue<List<Item>>?>>((ref) {
  final loaners = ref.watch(userLoanerList);
  LoanersItemsMapNotifier loanerLoanListNotifier = LoanersItemsMapNotifier();
  loanerLoanListNotifier.loadTList(loaners.map((loaner) => loaner.id).toList());
  return loanerLoanListNotifier;
});
