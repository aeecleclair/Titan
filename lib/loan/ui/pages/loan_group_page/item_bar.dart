import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/caution_provider.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/providers/start_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/check_item_card.dart';
import 'package:myecl/tools/constants.dart';

class ItemBar extends HookConsumerWidget {
  final bool isEdit;
  const ItemBar({
    Key? key,
    required this.isEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemListProvider);
    final selectedItems = ref.watch(editSelectedListProvider);
    final selectedItemsNotifier = ref.watch(editSelectedListProvider.notifier);
    final cautionNotifier = ref.watch(cautionProvider.notifier);
    final endNotifier = ref.watch(endProvider.notifier);
    final start = ref.watch(startProvider);
    return items.when(data: (itemList) {
      if (itemList.isNotEmpty) {
        final sortedAvailable = itemList.where((element) => element.available).toList()..sort((a, b) => a.name.compareTo(b.name));
        final sortedUnavailable = itemList.where((element) => !element.available).toList()..sort((a, b) => a.name.compareTo(b.name));
        itemList = sortedAvailable + sortedUnavailable;
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
                          if (selected.isNotEmpty) {
                            cautionNotifier.setCaution(
                                "${selected.fold<double>(0, (previousValue, element) => previousValue + element.caution).toStringAsFixed(2)}€");
                            endNotifier.setEndFromSelected(start, selected);
                          } else {
                            endNotifier.setEnd("");
                            cautionNotifier.setCaution("");
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
