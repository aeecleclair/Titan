import 'dart:core';

enum State { pending, retrieved, consumed }

enum PropagationMethod { cutting, seed }

class PlantCreation {
  final State state;
  final String speciesId; // UUID
  final PropagationMethod propagationMethod;
  final String? previousNote;
  final int nbSeedsEnvelope;
  final String plantReference;
  final String? ancestorId;
  final String? borrowerId;
  final String? currentNote;
  final bool confidential;
  final String? nickname;
  final DateTime? plantingDate;
  final DateTime? borrowingDate;

  PlantCreation({
    required this.state,
    required this.speciesId,
    required this.propagationMethod,
    this.previousNote,
    required this.nbSeedsEnvelope,
    required this.plantReference,
    this.ancestorId,
    this.borrowerId,
    this.currentNote,
    this.confidential = false,
    this.nickname,
    this.plantingDate,
    this.borrowingDate,
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'state': state.name,
      'speciesId': speciesId,
      'propagationMethod': propagationMethod.name,
      'previousNote': previousNote,
      'nbSeedsEnvelope': nbSeedsEnvelope,
      'plantReference': plantReference,
      'ancestorId': ancestorId,
      'borrowerId': borrowerId,
      'currentNote': currentNote,
      'confidential': confidential,
      'nickname': nickname,
      'plantingDate': plantingDate?.toIso8601String(),
      'borrowingDate': borrowingDate?.toIso8601String(),
    };
  }

  // Create an object from JSON
  factory PlantCreation.fromJson(Map<String, dynamic> json) {
    return PlantCreation(
      state: State.values.byName(json['state']),
      speciesId: json['speciesId'],
      propagationMethod:
          PropagationMethod.values.byName(json['propagationMethod']),
      previousNote: json['previousNote'],
      nbSeedsEnvelope: json['nbSeedsEnvelope'],
      plantReference: json['plantReference'],
      ancestorId: json['ancestorId'],
      borrowerId: json['borrowerId'],
      currentNote: json['currentNote'],
      confidential: json['confidential'] ?? false,
      nickname: json['nickname'],
      plantingDate: json['plantingDate'] != null
          ? DateTime.parse(json['plantingDate'])
          : null,
      borrowingDate: json['borrowingDate'] != null
          ? DateTime.parse(json['borrowingDate'])
          : null,
    );
  }
}
