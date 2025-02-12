import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/class/utils.dart';
import 'package:myecl/CMM/providers/sorting_score_bar_provider.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';

class SortingScoreBar extends HookConsumerWidget {
  const SortingScoreBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedSortingScoreProvider);
    final selectedNotifier = ref.watch(selectedSortingScoreProvider.notifier);
    const periods = Period.values;

    return HorizontalListView.builder(
      height: 40,
      items: periods,
      itemBuilder: (context, e, i) => GestureDetector(
        onTap: () {
          if (selected != e) {
            {
              selectedNotifier.setSortingPeriod(e);
            }
          }
        },
        child: ItemChip(
          selected: selected == e,
          child: Text(
            periodToString(e),
            style: TextStyle(
              color: selected == e ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
