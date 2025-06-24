import 'dart:core';

import 'package:titan/seed-library/tools/functions.dart';

class PlantCreation {
  final String speciesId; // UUID
  final PropagationMethod propagationMethod;
  final String? previousNote;
  final int nbSeedsEnvelope;
  final String? ancestorId;
  final bool confidential;

  PlantCreation({
    required this.speciesId,
    required this.propagationMethod,
    this.previousNote,
    required this.nbSeedsEnvelope,
    this.ancestorId,
    this.confidential = false,
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'species_id': speciesId,
      'propagation_method': propagationMethod.name,
      'previous_note': previousNote,
      'nb_seeds_envelope': nbSeedsEnvelope,
      'ancestor_id': ancestorId,
      'confidential': confidential,
    };
  }

  // Create an object from JSON
  factory PlantCreation.fromJson(Map<String, dynamic> json) {
    return PlantCreation(
      speciesId: json['species_id'],
      propagationMethod: PropagationMethod.values.byName(
        json['propagation_method'],
      ),
      previousNote: json['previous_note'],
      nbSeedsEnvelope: json['nb_seeds_envelope'],
      ancestorId: json['ancestor_id'],
      confidential: json['confidential'] ?? false,
    );
  }
}
