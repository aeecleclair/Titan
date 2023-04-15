import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/caution_provider.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/quantity_provider.dart';
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
        final sortedAvailable = itemList
            .where((element) => element.loanedQuantity < element.totalQuantity)
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));
        final sortedUnavailable = itemList
            .where((element) => element.loanedQuantity >= element.totalQuantity)
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));
        itemList = sortedAvailable + sortedUnavailable;
        return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(width: 15),
              ...itemList.map((e) {
                var currentValue = selectedItems[itemList.indexOf(e)];
                return Column(
                  children: [
                    CheckItemCard(
                      item: e,
                      onCheck: () {},
                      isSelected: currentValue != 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.exposure_minus_1_rounded,
                            color: currentValue == 0
                                ? Colors.grey.shade400
                                : Colors.black,
                          ),
                          onTap: () {
                            if (currentValue > 0) {
                              selectedItemsNotifier.set(
                                  itemList.indexOf(e), currentValue - 1);
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            currentValue.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: currentValue == 0
                                  ? Colors.grey.shade400
                                  : Colors.black,
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Icon(Icons.plus_one_rounded,
                          color: currentValue ==
                                e.totalQuantity - e.loanedQuantity
                                ? Colors.grey.shade400
                                : Colors.black,),
                          onTap: () {
                            if (currentValue <
                                e.totalQuantity - e.loanedQuantity) {
                              selectedItemsNotifier.set(
                                  itemList.indexOf(e), currentValue + 1);
                            }
                          },
                        )
                      ],
                    ),
                  ],
                );
              }),
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
