import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/class/utils.dart';
import 'package:myecl/CMM/providers/sorting_score_time_bar_provider.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';

class SortingScoreTimeBar extends HookConsumerWidget {
  const SortingScoreTimeBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedSortingScoreTimeProvider);
    final selectedNotifier =
        ref.watch(selectedSortingScoreTimeProvider.notifier);
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
