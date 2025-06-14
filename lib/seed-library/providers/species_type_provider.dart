import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/seed-library/class/species_type.dart';

final speciesTypeProvider =
    StateNotifierProvider<SpeciesTypeNotifier, SpeciesType>((ref) {
      return SpeciesTypeNotifier();
    });

class SpeciesTypeNotifier extends StateNotifier<SpeciesType> {
  SpeciesTypeNotifier() : super(SpeciesType(name: ""));

  void setType(SpeciesType i) {
    state = i;
  }
}
