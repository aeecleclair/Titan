import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/seed-library/class/species.dart';

final speciesProvider = StateNotifierProvider<SpeciesNotifier, Species>((ref) {
  return SpeciesNotifier();
});

class SpeciesNotifier extends StateNotifier<Species> {
  SpeciesNotifier() : super(Species.empty());

  void setPlant(Species i) {
    state = i;
  }
}
