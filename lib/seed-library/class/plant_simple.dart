import 'dart:core';

import 'package:myecl/seed-library/tools/functions.dart';

class PlantSimple {
  final State state;
  final String speciesId; // UUID
  final PropagationMethod propagationMethod;
  final String plantReference;
  final String id; //UUID
  final String? borrowerId;
  final String? nickname;

  PlantSimple({
    required this.state,
    required this.speciesId,
    required this.propagationMethod,
    required this.id,
    required this.plantReference,
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
      'plant_reference': plantReference,
      'borrower_id': borrowerId,
      'nickname': nickname,
    };
  }

  // Create an object from JSON
  factory PlantSimple.fromJson(Map<String, dynamic> json) {
    return PlantSimple(
      state: getStateByValue(json['state']),
      speciesId: json['species_id'],
      propagationMethod:
          getPropagationMethodByValue(json['propagation_method']),
      id: json['id'],
      plantReference: json['plant_reference'],
      borrowerId: json['borrower_id'],
      nickname: json['nickname'],
    );
  }

  PlantSimple.empty()
      : state = State.pending,
        speciesId = '',
        propagationMethod = PropagationMethod.graine,
        id = '',
        plantReference = '',
        borrowerId = null,
        nickname = null;

  PlantSimple copyWith({
    State? state,
    String? speciesId,
    PropagationMethod? propagationMethod,
    String? id,
    String? plantReference,
    String? borrowerId,
    String? nickname,
  }) {
    return PlantSimple(
      state: state ?? this.state,
      speciesId: speciesId ?? this.speciesId,
      propagationMethod: propagationMethod ?? this.propagationMethod,
      id: id ?? this.id,
      plantReference: plantReference ?? this.plantReference,
      borrowerId: borrowerId ?? this.borrowerId,
      nickname: nickname ?? this.nickname,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlantSimple && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
