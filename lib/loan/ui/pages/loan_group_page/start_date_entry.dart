import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/loan/providers/end_provider.dart';
import 'package:titan/loan/providers/initial_date_provider.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/providers/selected_items_provider.dart';
import 'package:titan/loan/providers/start_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/l10n/app_localizations.dart';

class StartDateEntry extends HookConsumerWidget {
  const StartDateEntry({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
    final items = ref.watch(itemListProvider);
    final selectedItems = ref.watch(editSelectedListProvider);
    final endNotifier = ref.watch(endProvider.notifier);
    final start = ref.watch(startProvider);
    final startNotifier = ref.watch(startProvider.notifier);
    final initialDateNotifier = ref.watch(initialDateProvider.notifier);
    final DateTime now = DateTime.now();

    return DateEntry(
      onTap: () => getOnlyDayDateFunction(
        context,
        (date) {
          startNotifier.setStart(date);
          items.whenData((itemList) {
            List<Item> selected = itemList
                .where(
                  (element) => selectedItems[itemList.indexOf(element)] != 0,
                )
                .toList();
            if (selected.isNotEmpty) {
              endNotifier.setEndFromSelected(date, selected, locale.toString());
            } else {
              endNotifier.setEnd("");
            }
            initialDateNotifier.setDate(DateTime.parse(processDateBack(date, locale.toString())));
          });
        },
        initialDate: start.isNotEmpty
            ? DateTime.parse(processDateBack(start, locale.toString()))
            : now,
        firstDate: DateTime(now.year - 1, now.month, now.day),
      ),
      label: AppLocalizations.of(context)!.loanBeginDate,
      controller: TextEditingController(text: start),
    );
  }
}
