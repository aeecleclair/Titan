import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/providers/year_list_provider.dart';
import 'package:titan/ph/providers/selected_year_list_provider.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';

class YearBar extends HookConsumerWidget {
  const YearBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedYearListProvider);
    final selectedNotifier = ref.watch(selectedYearListProvider.notifier);
    final yearList = ref.watch(yearListProvider);

    return HorizontalListView.builder(
      height: 40,
      items: yearList,
      itemBuilder: (context, e, i) => GestureDetector(
        onTap: () {
          if (selected.contains(e)) {
            {
              selectedNotifier.removeYear(e);
            }
          } else {
            selectedNotifier.addYear(e);
          }
        },
        child: ItemChip(
          selected: selected.contains(e),
          child: Text(
            e.toString(),
            style: TextStyle(
              color: selected.contains(e) ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
