import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/class/species_type.dart';
import 'package:myecl/seed-library/providers/difficulty_filter_provider.dart';
import 'package:myecl/seed-library/providers/season_filter_provider.dart';
import 'package:myecl/seed-library/providers/species_type_filter_provider.dart';
import 'package:myecl/seed-library/providers/species_type_list_provider.dart';

class FiltersBar extends HookConsumerWidget {
  const FiltersBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difficulty = ref.watch(difficultyFilterProvider);
    final difficultyNotifier = ref.watch(difficultyFilterProvider.notifier);
    final season = ref.watch(seasonFilterProvider);
    final seasonNotifier = ref.watch(seasonFilterProvider.notifier);
    final speciesTypeList = ref.watch(syncSpeciesTypeListProvider);
    final speciesType = ref.watch(speciesTypeFilterProvider);
    final speciesTypeNotifier = ref.watch(speciesTypeFilterProvider.notifier);

    return ExpansionTile(
      title: Text('Filters'),
      children: [
        Row(
          children: [
            Spacer(),
            Column(
              children: [
                Text('Season: '),
                DropdownButton<String>(
                  value: season,
                  onChanged: (String? newValue) {
                    seasonNotifier.setFilter(newValue!);
                  },
                  items: <String>[
                    'toutes',
                    'printemps',
                    'été',
                    'automne',
                    'hiver',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Text('Difficulty: '),
                Slider(
                  value: difficulty.toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  label: difficulty.toString(),
                  onChanged: (double value) {
                    difficultyNotifier.setFilter(value.toInt());
                  },
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Text('Species type: '),
                DropdownButton<SpeciesType>(
                  value: speciesType,
                  onChanged: (SpeciesType? newValue) {
                    speciesTypeNotifier.setFilter(newValue!);
                  },
                  items: speciesTypeList
                      .map<DropdownMenuItem<SpeciesType>>((SpeciesType value) {
                    return DropdownMenuItem<SpeciesType>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
