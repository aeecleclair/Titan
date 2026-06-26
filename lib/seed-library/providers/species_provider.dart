import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class SpeciesNotifier extends Notifier<SpeciesComplete> {
  @override
  SpeciesComplete build() => SpeciesComplete.empty();

  void setSpecies(SpeciesComplete i) {
    state = i;
  }
}

final speciesProvider = NotifierProvider<SpeciesNotifier, SpeciesComplete>(
  SpeciesNotifier.new,
);
