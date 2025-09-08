import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/seed-library/class/species.dart';

final speciesProvider = StateNotifierProvider<SpeciesNotifier, Species>((ref) {
  return SpeciesNotifier();
});

class SpeciesNotifier extends StateNotifier<Species> {
  SpeciesNotifier() : super(Species.empty());

  void setSpecies(Species i) {
    state = i;
  }
}
