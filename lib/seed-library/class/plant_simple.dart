import 'dart:core';

import 'package:titan/seed-library/tools/functions.dart';
import 'package:titan/tools/functions.dart';

class PlantSimple {
  final State state;
  final String speciesId; // UUID
  final PropagationMethod propagationMethod;
  final String plantReference;
  final String id; //UUID
  final String? borrowerId;
  final String? nickname;
  final int nbSeedsEnvelope;
  final DateTime? plantingDate;

  PlantSimple({
    required this.state,
    required this.speciesId,
    required this.propagationMethod,
    required this.id,
    required this.plantReference,
    required this.nbSeedsEnvelope,
    this.plantingDate,
    this.borrowerId,
    this.nickname,
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'state': getStateValue(state),
      'species_id': speciesId,
      'propagation_method': getPropagationMethodValue(propagationMethod),
      'id': id,
      'reference': plantReference,
      'borrower_id': borrowerId,
      'nickname': nickname,
      'nb_seeds_envelope': nbSeedsEnvelope,
      'planting_date': plantingDate != null
          ? processDateToAPIWithoutHour(plantingDate!)
          : null,
    };
  }

  // Create an object from JSON
  factory PlantSimple.fromJson(Map<String, dynamic> json) {
    return PlantSimple(
      state: getStateByValue(json['state']),
      speciesId: json['species_id'],
      propagationMethod: getPropagationMethodByValue(
        json['propagation_method'],
      ),
      id: json['id'],
      plantReference: json['reference'],
      borrowerId: json['borrower_id'],
      nickname: json['nickname'],
      nbSeedsEnvelope: json['nb_seeds_envelope'],
      plantingDate: json['planting_date'] != null
          ? processDateFromAPIWithoutHour(json['planting_date'])
          : null,
    );
  }

  PlantSimple.empty()
    : state = State.pending,
      speciesId = '',
      propagationMethod = PropagationMethod.graine,
      id = '',
      plantReference = '',
      borrowerId = null,
      nickname = null,
      nbSeedsEnvelope = 0,
      plantingDate = null;

  PlantSimple copyWith({
    State? state,
    String? speciesId,
    PropagationMethod? propagationMethod,
    String? id,
    String? plantReference,
    String? borrowerId,
    String? nickname,
    int? nbSeedsEnvelope,
    DateTime? plantingDate,
  }) {
    return PlantSimple(
      state: state ?? this.state,
      speciesId: speciesId ?? this.speciesId,
      propagationMethod: propagationMethod ?? this.propagationMethod,
      id: id ?? this.id,
      plantReference: plantReference ?? this.plantReference,
      borrowerId: borrowerId ?? this.borrowerId,
      nickname: nickname ?? this.nickname,
      nbSeedsEnvelope: nbSeedsEnvelope ?? this.nbSeedsEnvelope,
      plantingDate: plantingDate ?? this.plantingDate,
    );
  }

  @override
  String toString() {
    return 'PlantSimple(state: $state, speciesId: $speciesId, propagationMethod: $propagationMethod, id: $id, plantReference: $plantReference, borrowerId: $borrowerId, nickname: $nickname, nbSeedsEnvelope: $nbSeedsEnvelope, plantingDate: $plantingDate)';
  }
}
