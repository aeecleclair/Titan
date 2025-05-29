import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/seed-library/class/species_type.dart';
import 'package:myecl/seed-library/tools/constants.dart';

final speciesTypeFilterProvider =
    StateNotifierProvider<FilterNotifier, SpeciesType>((ref) {
      return FilterNotifier();
    });

class FilterNotifier extends StateNotifier<SpeciesType> {
  FilterNotifier() : super(SpeciesType(name: SeedLibraryTextConstants.all));

  void setFilter(SpeciesType i) {
    state = i;
  }
}
