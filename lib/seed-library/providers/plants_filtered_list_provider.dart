import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diacritic/diacritic.dart';
import 'package:titan/seed-library/class/plant_simple.dart';
import 'package:titan/seed-library/class/species.dart';
import 'package:titan/seed-library/class/species_type.dart';
import 'package:titan/seed-library/providers/consumed_filter_provider.dart';
import 'package:titan/seed-library/providers/difficulty_filter_provider.dart';
import 'package:titan/seed-library/providers/plants_list_provider.dart';
import 'package:titan/seed-library/providers/species_type_filter_provider.dart';
import 'package:titan/seed-library/providers/string_provider.dart';
import 'package:titan/seed-library/providers/species_list_provider.dart';
import 'package:titan/seed-library/tools/constants.dart';
import 'package:titan/seed-library/tools/functions.dart';

List<int> getMonthsBySeason(String season) {
  if (season == SeedLibraryTextConstants.spring) {
    return [4, 5, 6];
  }
  if (season == SeedLibraryTextConstants.summer) {
    return [7, 8, 9];
  }
  if (season == SeedLibraryTextConstants.autumn) {
    return [10, 11, 12];
  }
  if (season == SeedLibraryTextConstants.winter) {
    return [1, 2, 3];
  }
  return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
}

List<Species> filterSpeciesWithFilters(
  List<Species> speciesList,
  String searchFilter,
  String seasonsTypeFilter,
  int difficultyTypeFilter,
  SpeciesType speciesTypeFilter,
) {
  List<Species> filteredSpecies = speciesList
      .where(
        (species) => searchFilter == ""
            ? true
            : removeDiacritics(
                species.name.toLowerCase(),
              ).contains(removeDiacritics(searchFilter.toLowerCase())),
      )
      .toList();
  filteredSpecies = filteredSpecies
      .where(
        (species) => seasonsTypeFilter == SeedLibraryTextConstants.all
            ? true
            : species.startSeason == null
            ? true
            : getMonthsBySeason(
                seasonsTypeFilter,
              ).contains(species.startSeason!.month),
      )
      .toList();
  filteredSpecies = filteredSpecies
      .where(
        (species) => difficultyTypeFilter == 0
            ? true
            : species.difficulty == difficultyTypeFilter,
      )
      .toList();
  filteredSpecies = filteredSpecies
      .where(
        (species) =>
            speciesTypeFilter == SpeciesType(name: SeedLibraryTextConstants.all)
            ? true
            : species.type == speciesTypeFilter,
      )
      .toList();
  return filteredSpecies;
}

final plantsFilteredListProvider = Provider<List<PlantSimple>>((ref) {
  final plantsProvider = ref.watch(plantListProvider);
  final speciesProvider = ref.watch(speciesListProvider);
  final speciesTypeFilter = ref.watch(speciesTypeFilterProvider);
  final seasonsFilter = ref.watch(seasonFilterProvider);
  final difficultyFilter = ref.watch(difficultyFilterProvider);
  final searchFilter = ref.watch(searchFilterProvider);
  List<Species> filteredSpecies = [];
  speciesProvider.maybeWhen(
    data: (speciesList) {
      filteredSpecies = filterSpeciesWithFilters(
        speciesList,
        searchFilter,
        seasonsFilter,
        difficultyFilter,
        speciesTypeFilter,
      );
    },
    orElse: () => null,
  );
  final speciesId = filteredSpecies.map((species) => species.id).toList();
  return plantsProvider.maybeWhen(
    data: (plants) {
      final filteredPlants = plants
          .where((plant) => speciesId.contains(plant.speciesId))
          .toList();
      filteredPlants.sort(
        (a, b) => a.plantReference.compareTo(b.plantReference),
      );
      return filteredPlants;
    },
    orElse: () => [],
  );
});

final myPlantsFilteredListProvider = Provider<List<PlantSimple>>((ref) {
  final plants = ref.watch(syncMyPlantListProvider);
  final species = ref.watch(syncSpeciesListProvider);
  final speciesTypeFilter = ref.watch(speciesTypeFilterProvider);
  final seasonsFilter = ref.watch(seasonFilterProvider);
  final difficultyFilter = ref.watch(difficultyFilterProvider);
  final searchFilter = ref.watch(searchFilterProvider);
  final consummedFilter = ref.watch(consumedFilterProvider);

  List<Species> filteredSpecies = filterSpeciesWithFilters(
    species,
    searchFilter,
    seasonsFilter,
    difficultyFilter,
    speciesTypeFilter,
  );
  final speciesId = filteredSpecies.map((species) => species.id).toList();
  final filteredPlants = plants
      .where((plant) => speciesId.contains(plant.speciesId))
      .toList();
  if (!consummedFilter) {
    filteredPlants.removeWhere((plant) => plant.state == State.consumed);
  }
  filteredPlants.sort((a, b) => a.plantReference.compareTo(b.plantReference));
  return filteredPlants;
});
