import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/date_entry.dart';
import 'package:myecl/tools/functions.dart';

class StartDateEntry extends HookConsumerWidget {
  final TextEditingController start;
  final TextEditingController end;
  final ValueNotifier<DateTime> initialDate;
  final Function(List<Item>) evaluateEnd;
const StartDateEntry({ Key? key,
    required this.start,
    required this.end,
    required this.initialDate,
    required this.evaluateEnd,
 }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemListProvider);
    final selectedItems = ref.watch(editSelectedListProvider);
    return DateEntry(
                  title: LoanTextConstants.beginDate,
                  controller: start,
                  dateBefore: DateTime.now(),
                  onSelect: () {
                    items.whenData((itemList) {
                      List<Item> selected = itemList
                          .where((element) =>
                              selectedItems[itemList.indexOf(element)])
                          .toList();
                      if (selected.isNotEmpty) {
                        evaluateEnd(selected);
                      } else {
                        end.text = "";
                      }
                      initialDate.value =
                          DateTime.parse(processDateBack(start.text));
                    });
                  },
                );
  }
}