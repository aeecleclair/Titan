import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/seed-library/class/species_type.dart';
import 'package:titan/seed-library/providers/difficulty_filter_provider.dart';
import 'package:titan/seed-library/providers/species_type_filter_provider.dart';
import 'package:titan/seed-library/providers/species_type_list_provider.dart';
import 'package:titan/seed-library/providers/string_provider.dart';
import 'package:titan/seed-library/tools/constants.dart';

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
      title: Text(SeedLibraryTextConstants.filters),
      children: [
        Column(
          children: [
            Column(
              children: [
                Text(SeedLibraryTextConstants.season),
                DropdownButton<String>(
                  value: season,
                  onChanged: (String? newValue) {
                    seasonNotifier.setString(newValue!);
                  },
                  items:
                      <String>[
                        SeedLibraryTextConstants.all,
                        SeedLibraryTextConstants.spring,
                        SeedLibraryTextConstants.summer,
                        SeedLibraryTextConstants.autumn,
                        SeedLibraryTextConstants.winter,
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: Column(
                children: [
                  Text(SeedLibraryTextConstants.difficulty),
                  Slider(
                    value: difficulty.toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    onChanged: (double value) {
                      difficultyNotifier.setFilter(value.toInt());
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Text(SeedLibraryTextConstants.speciesType),
                DropdownButton<SpeciesType>(
                  value: speciesType,
                  onChanged: (SpeciesType? newValue) {
                    speciesTypeNotifier.setFilter(newValue!);
                  },
                  items: [SpeciesType.empty(), ...speciesTypeList]
                      .map<DropdownMenuItem<SpeciesType>>((SpeciesType value) {
                        return DropdownMenuItem<SpeciesType>(
                          value: value,
                          child: Text(value.name),
                        );
                      })
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
