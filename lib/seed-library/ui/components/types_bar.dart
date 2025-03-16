import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/class/species_type.dart';
import 'package:myecl/seed-library/providers/species_type_list_provider.dart';
import 'package:myecl/seed-library/providers/species_type_provider.dart';
import 'package:myecl/seed-library/ui/components/radio_chip.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class TypesBar extends HookConsumerWidget {
  TypesBar({super.key});
  final dataKey = GlobalKey();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(speciesTypeProvider);
    final typeNotifier = ref.watch(speciesTypeProvider.notifier);
    final speciesTypes = ref.watch(speciesTypeListProvider);
    useEffect(
      () {
        Future(() {
          if (type != SpeciesType.empty()) {
            Scrollable.ensureVisible(
              dataKey.currentContext!,
              duration: const Duration(milliseconds: 500),
              alignment: 0.5,
            );
          }
        });
        return;
      },
      [dataKey],
    );
    return AsyncChild(
      value: speciesTypes,
      builder: (context, types) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: types.length,
          itemBuilder: (context, index) {
            final item = types[index];
            final selected = type == item;
            return RadioChip(
              key: selected ? dataKey : null,
              onTap: () {
                typeNotifier.setType(!selected ? item : SpeciesType.empty());
              },
              selected: selected,
              label: item.name,
            );
          },
        ),
      ),
    );
  }
}
