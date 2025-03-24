import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/sorting_score_entity_bar_provider.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';

class SortingScoreEntityBar extends HookConsumerWidget {
  const SortingScoreEntityBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedSortingScoreEntityProvider);
    final selectedNotifier =
        ref.watch(selectedSortingScoreEntityProvider.notifier);
    const entities = Entity.values;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: entities.map((e) {
          return GestureDetector(
            onTap: () {
              if (selected != e) {
                selectedNotifier.setSortingPeriod(e);
              }
            },
            child: ItemChip(
              selected: selected == e,
              child: Text(
                entityToString(e),
                style: TextStyle(
                  color: selected == e ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
