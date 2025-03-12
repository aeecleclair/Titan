import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diacritic/diacritic.dart';
import 'package:image/image.dart';
import 'package:myecl/seed-library/class/plant_simple.dart';
import 'package:myecl/seed-library/class/species.dart';
import 'package:myecl/seed-library/providers/difficulty_filter_provider.dart';
import 'package:myecl/seed-library/providers/plants_list_provider.dart';
import 'package:myecl/seed-library/providers/research_filter_provider%20copy%202.dart';
import 'package:myecl/seed-library/providers/season_filter_provider.dart';
import 'package:myecl/seed-library/providers/species_list_provider.dart';

List<int> getMonthsBySeason(String season) {
  if (season == "printemps") {
    return [4, 5, 6];
  }
  if (season == "été") {
    return [7, 8, 9];
  }
  if (season == "automne") {
    return [10, 11, 12];
  }
  if (season == "hiver") {
    return [1, 2, 3];
  }
  return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
}

final plantFilteredListProvider = Provider<List<PlantSimple>>((ref) {
  final plantsProvider = ref.watch(plantListProvider);
  final speciesProvider = ref.watch(speciesListProvider);
  final speciesTypeFilter = ref.watch(speciesTypeFilterProvider);
  final seasonsTypeFilter = ref.watch(seasonFilterProvider);
  final difficultyTypeFilter = ref.watch(difficultyFilterProvider);
  final searchFilter = ref.watch(filterProvider);
  List<Species> filteredSpecies = [];
  speciesProvider.maybeWhen(
      data: (speciesList) {
        filteredSpecies = speciesList
            .where(
              (species) => removeDiacritics(species.name.toLowerCase())
                  .contains(removeDiacritics(searchFilter.toLowerCase())),
            )
            .toList();
        filteredSpecies = filteredSpecies
            .where((species) => species.startSeason == null
                ? true
                : getMonthsBySeason(seasonsTypeFilter)
                    .contains(species.startSeason!.month))
            .toList();
        filteredSpecies = filteredSpecies
            .where((species) => species.difficulty == difficultyTypeFilter)
            .toList();
        filteredSpecies = filteredSpecies
            .where((species) => species.type == speciesTypeFilter)
            .toList();
      },
      orElse: () => null);
  final speciesId = filteredSpecies.map((species) => species.id).toList();
  return plantsProvider.maybeWhen(
    data: (plants) {
      List<PlantSimple> filteredPlants = plants
          .where(
            (plant) => speciesId.contains(plant.speciesId),
          )
          .toList();
      return filteredPlants;
    },
    orElse: () => [],
  );
});
