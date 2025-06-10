import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/providers/association_kind_provider.dart';
import 'package:titan/phonebook/providers/association_kinds_provider.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';

class KindsBar extends HookConsumerWidget {
  KindsBar({super.key});
  final dataKey = GlobalKey();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kind = ref.watch(associationKindProvider);
    final kindNotifier = ref.watch(associationKindProvider.notifier);
    final associationKinds = ref.watch(associationKindsProvider);
    useEffect(() {
      Future(() {
        if (kind != "") {
          Scrollable.ensureVisible(
            dataKey.currentContext!,
            duration: const Duration(milliseconds: 500),
            alignment: 0.5,
          );
        }
      });
      return;
    }, [dataKey]);
    return AsyncChild(
      value: associationKinds,
      builder: (context, kinds) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: kinds.kinds.length,
          itemBuilder: (context, index) {
            final item = kinds.kinds[index];
            final selected = kind == item;
            return ItemChip(
              key: selected ? dataKey : null,
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
      ),
    );
  }
}
