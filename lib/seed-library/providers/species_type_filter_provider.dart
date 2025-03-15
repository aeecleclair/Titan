import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/seed-library/class/species_type.dart';

final speciesTypeFilterProvider =
    StateNotifierProvider<FilterNotifier, SpeciesType>((ref) {
  return FilterNotifier();
});

class FilterNotifier extends StateNotifier<SpeciesType> {
  FilterNotifier() : super(SpeciesType(name: "all"));

  void setFilter(SpeciesType i) {
    state = i;
  }
}
