import 'package:myecl/seed-library/class/plant_simple.dart';
import 'package:myecl/seed-library/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

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
      'previous_note': previousNote,
      'nbSeeds_envelope': nbSeedsEnvelope,
      'ancestor_id': ancestorId,
      'currentenote': currentNote,
      'confidential': confidential,
      'planting_date': plantingDate != null
          ? processDateToAPIWithoutHour(plantingDate!)
          : null,
      'borrowing_date': borrowingDate != null
          ? processDateToAPIWithoutHour(borrowingDate!)
          : null,
    });
    return json;
  }

  factory PlantComplete.fromJson(Map<String, dynamic> json) {
    return PlantComplete(
      state: getStateByValue(json['state']),
      speciesId: json['species_id'],
      propagationMethod:
          getPropagationMethodByValue(json['propagation_method']),
      id: json['id'],
      plantReference: json['plant_reference'],
      borrowerId: json['borrower_id'],
      nickname: json['nickname'],
      previousNote: json['previous_note'],
      nbSeedsEnvelope: json['nb_seeds_envelope'],
      ancestorId: json['ancestor_id'],
      currentNote: json['current_note'],
      confidential: json['confidential'] ?? false,
      plantingDate: json['planting_date'] != null
          ? processDateFromAPIWithoutHour(json['planting_date'])
          : null,
      borrowingDate: json['borrowing_date'] != null
          ? processDateFromAPIWithoutHour(json['borrowing_date'])
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
