import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_kind_provider.dart';
import 'package:myecl/phonebook/providers/association_kinds_provider.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';

class KindsBar extends ConsumerWidget {
  const KindsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kind = ref.watch(associationKindProvider);
    final kindNotifier = ref.watch(associationKindProvider.notifier);
    final associationKinds = ref.watch(associationKindsProvider);

    return AsyncChild(
      value: associationKinds,
      builder: (context, kinds) => HorizontalListView.builder(
        height: 40,
        items: kinds.kinds,
        itemBuilder: (context, item, index) {
          final selected = kind == item;
          return ItemChip(
            onTap: () {
              kindNotifier.setKind(!selected ? item : "");
            },
            selected: selected,
            child: Text(
              item,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
