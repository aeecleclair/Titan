import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/seed-library/providers/species_type_list_provider.dart';
import 'package:titan/seed-library/providers/species_type_provider.dart';
import 'package:titan/seed-library/ui/components/radio_chip.dart';
import 'package:titan/tools/ui/builders/async_child.dart';

class TypesBar extends HookConsumerWidget {
  TypesBar({super.key});
  final dataKey = GlobalKey();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(speciesTypeProvider);
    final typeNotifier = ref.watch(speciesTypeProvider.notifier);
    final speciesTypes = ref.watch(speciesTypeListProvider);

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
            return RadioChip(
              onTap: () {
                typeNotifier.setType(item);
              },
              selected: type.name == item.name,
              label: item.name,
            );
          },
        ),
      ),
    );
  }
}
