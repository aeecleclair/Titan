import 'dart:core';

enum State { pending, retrieved, consumed }

enum PropagationMethod { cutting, seed }

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
      'state': state.name,
      'speciesId': speciesId,
      'propagationMethod': propagationMethod.name,
      'id': id,
      'plantReference': plantReference,
      'borrowerId': borrowerId,
      'nickname': nickname,
    };
  }

  // Create an object from JSON
  factory PlantSimple.fromJson(Map<String, dynamic> json) {
    return PlantSimple(
      state: State.values.byName(json['state']),
      speciesId: json['speciesId'],
      propagationMethod:
          PropagationMethod.values.byName(json['propagationMethod']),
      id: json['id'],
      plantReference: json['plantReference'],
      borrowerId: json['borrowerId'],
      nickname: json['nickname'],
    );
  }

  PlantSimple.empty()
      : state = State.pending,
        speciesId = '',
        propagationMethod = PropagationMethod.seed,
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
}
