import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/class/sorting_type.dart';
import 'package:myecl/CMM/providers/sorting_bar_provider.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';

class SortingBar extends HookConsumerWidget {
  const SortingBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedSortingTypeProvider);
    final selectedNotifier = ref.watch(selectedSortingTypeProvider.notifier);
    const sortingTypes = SortingType.values;

    return HorizontalListView.builder(
      height: 40,
      items: sortingTypes,
      itemBuilder: (context, e, i) => GestureDetector(
        onTap: () {
          if (selected != e) {
            {
              selectedNotifier.setSortingType(e);
            }
          }
        },
        child: ItemChip(
          selected: selected == e,
          child: Text(
            sortingTypeToString(e),
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