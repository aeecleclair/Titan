import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/loan/providers/initial_date_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/providers/start_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

class StartDateEntry extends HookConsumerWidget {
  const StartDateEntry({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemListProvider);
    final selectedItems = ref.watch(editSelectedListProvider);
    final endNotifier = ref.watch(endProvider.notifier);
    final start = ref.watch(startProvider);
    final startNotifier = ref.watch(startProvider.notifier);
    final initialDateNotifier = ref.watch(initialDateProvider.notifier);
    final DateTime now = DateTime.now();

    return GestureDetector(
      onTap: () => getOnlyDayDateFunction(
        context,
        (date) {
          startNotifier.setStart(date);
          items.whenData((itemList) {
            final sortedAvailable = itemList
                .where(
                    (element) => element.loanedQuantity < element.totalQuantity)
                .toList()
              ..sort((a, b) => a.name.compareTo(b.name));
            final sortedUnavailable = itemList
                .where((element) =>
                    element.loanedQuantity >= element.totalQuantity)
                .toList()
              ..sort((a, b) => a.name.compareTo(b.name));
            itemList = sortedAvailable + sortedUnavailable;
            List<Item> selected = itemList
                .where(
                    (element) => selectedItems[itemList.indexOf(element)] != 0)
                .toList();
            if (selected.isNotEmpty) {
              endNotifier.setEndFromSelected(date, selected);
            } else {
              endNotifier.setEnd("");
            }
            initialDateNotifier.setDate(DateTime.parse(processDateBack(date)));
          });
        },
        initialDate:
            start.isNotEmpty ? DateTime.parse(processDateBack(start)) : now,
        firstDate: DateTime(now.year - 1, now.month, now.day),
      ),
      child: SizedBox(
        child: AbsorbPointer(
          child: TextFormField(
            controller: TextEditingController(text: start),
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              labelText: LoanTextConstants.beginDate,
              floatingLabelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return LoanTextConstants.enterDate;
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
