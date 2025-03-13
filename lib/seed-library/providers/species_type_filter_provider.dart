import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/seed-library/class/species.dart';

final speciesTypeFilterProvider =
    StateNotifierProvider<FilterNotifier, TypeSpecies>((ref) {
  return FilterNotifier();
});

class FilterNotifier extends StateNotifier<TypeSpecies> {
  FilterNotifier() : super(TypeSpecies.all);

  void setFilter(TypeSpecies i) {
    state = i;
  }
}
