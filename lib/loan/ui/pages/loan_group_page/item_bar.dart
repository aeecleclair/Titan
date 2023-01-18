import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/check_item_card.dart';
import 'package:myecl/tools/constants.dart';

class ItemBar extends HookConsumerWidget {
  final bool isEdit;
  final ValueNotifier<int> numberSelected;
  final TextEditingController caution, end;
  final Function(List<Item>) evaluateEnd;
  const ItemBar({Key? key, required this.isEdit,
    required this.numberSelected,
    required this.caution,
    required this.end,
    required this.evaluateEnd
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemListProvider);
    final selectedItems = ref.watch(editSelectedListProvider);
    final selectedItemsNotifier = ref.watch(editSelectedListProvider.notifier);
    return items.when(data: (itemList) {
      if (itemList.isNotEmpty) {
        return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(width: 15),
              ...itemList.map(
                (e) => CheckItemCard(
                  item: e,
                  onCheck: () async {
                    if (e.available || isEdit) {
                      selectedItemsNotifier.toggle(itemList.indexOf(e)).then(
                        (value) {
                          List<Item> selected = itemList
                              .where(
                                  (element) => value[itemList.indexOf(element)])
                              .toList();
                          numberSelected.value = selected.length;
                          if (numberSelected.value > 0) {
                            caution.text =
                                "${selected.fold<double>(0, (previousValue, element) => previousValue + element.caution).toStringAsFixed(2)}€";
                            evaluateEnd(selected);
                          } else {
                            end.text = "";
                            caution.text = "";
                          }
                        },
                      );
                    }
                  },
                  isSelected: selectedItems[itemList.indexOf(e)],
                ),
              ),
              const SizedBox(width: 15),
            ]));
      } else {
        return const SizedBox(
          height: 160,
          child: Center(
              child: Text(LoanTextConstants.noItems,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
        );
      }
    }, error: (error, s) {
      return SizedBox(
        height: 160,
        child: Text(error.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      );
    }, loading: () {
      return const SizedBox(
        height: 160,
        child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorConstants.background2)),
      );
    });
  }
}
