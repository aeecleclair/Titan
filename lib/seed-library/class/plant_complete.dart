import 'package:myecl/seed-library/class/plant_simple.dart';

class PlantComplete extends PlantSimple {
  final String? previousNote;
  final int nbSeedsEnvelope;
  final String? ancestorId;
  final String? currentNote;
  final bool confidential;
  final DateTime? plantingDate;
  final DateTime? borrowingDate;

  PlantComplete({
    required super.state,
    required super.speciesId,
    required super.propagationMethod,
    required super.id,
    required super.plantReference,
    super.borrowerId,
    super.nickname,
    this.previousNote,
    required this.nbSeedsEnvelope,
    this.ancestorId,
    this.currentNote,
    this.confidential = false,
    this.plantingDate,
    this.borrowingDate,
  });

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'previousNote': previousNote,
      'nbSeedsEnvelope': nbSeedsEnvelope,
      'ancestorId': ancestorId,
      'currentNote': currentNote,
      'confidential': confidential,
      'plantingDate': plantingDate?.toIso8601String(),
      'borrowingDate': borrowingDate?.toIso8601String(),
    });
    return json;
  }

  factory PlantComplete.fromJson(Map<String, dynamic> json) {
    return PlantComplete(
      state: State.values.byName(json['state']),
      speciesId: json['speciesId'],
      propagationMethod:
          PropagationMethod.values.byName(json['propagationMethod']),
      id: json['id'],
      plantReference: json['plantReference'],
      borrowerId: json['borrowerId'],
      nickname: json['nickname'],
      previousNote: json['previousNote'],
      nbSeedsEnvelope: json['nbSeedsEnvelope'],
      ancestorId: json['ancestorId'],
      currentNote: json['currentNote'],
      confidential: json['confidential'] ?? false,
      plantingDate: json['plantingDate'] != null
          ? DateTime.parse(json['plantingDate'])
          : null,
      borrowingDate: json['borrowingDate'] != null
          ? DateTime.parse(json['borrowingDate'])
          : null,
    );
  }

  @override
  PlantComplete copyWith({
    State? state,
    String? speciesId,
    PropagationMethod? propagationMethod,
    String? id,
    String? plantReference,
    String? borrowerId,
    String? nickname,
    String? previousNote,
    int? nbSeedsEnvelope,
    String? ancestorId,
    String? currentNote,
    bool? confidential,
    DateTime? plantingDate,
    DateTime? borrowingDate,
  }) {
    return PlantComplete(
      state: state ?? this.state,
      speciesId: speciesId ?? this.speciesId,
      propagationMethod: propagationMethod ?? this.propagationMethod,
      id: id ?? this.id,
      plantReference: plantReference ?? this.plantReference,
      borrowerId: borrowerId ?? this.borrowerId,
      nickname: nickname ?? this.nickname,
      previousNote: previousNote ?? this.previousNote,
      nbSeedsEnvelope: nbSeedsEnvelope ?? this.nbSeedsEnvelope,
      ancestorId: ancestorId ?? this.ancestorId,
      currentNote: currentNote ?? this.currentNote,
      confidential: confidential ?? this.confidential,
      plantingDate: plantingDate ?? this.plantingDate,
      borrowingDate: borrowingDate ?? this.borrowingDate,
    );
  }
}
