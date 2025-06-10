import 'package:titan/seed-library/class/plant_simple.dart';
import 'package:titan/seed-library/tools/functions.dart';
import 'package:titan/tools/functions.dart';

class PlantComplete extends PlantSimple {
  final String? previousNote;
  final String? ancestorId;
  final String? currentNote;
  final bool confidential;
  final DateTime? borrowingDate;

  PlantComplete({
    required super.state,
    required super.speciesId,
    required super.propagationMethod,
    required super.id,
    required super.plantReference,
    required super.nbSeedsEnvelope,
    super.borrowerId,
    super.nickname,
    super.plantingDate,
    this.previousNote,
    this.ancestorId,
    this.currentNote,
    this.confidential = false,
    this.borrowingDate,
  });

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'previous_note': previousNote,
      'nbSeeds_envelope': nbSeedsEnvelope,
      'ancestor_id': ancestorId,
      'current_note': currentNote,
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
      propagationMethod: getPropagationMethodByValue(
        json['propagation_method'],
      ),
      id: json['id'],
      plantReference: json['reference'],
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

  factory PlantComplete.empty() {
    return PlantComplete(
      state: State.pending,
      speciesId: '',
      propagationMethod: PropagationMethod.graine,
      id: '',
      plantReference: '',
      nbSeedsEnvelope: 0,
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

  PlantSimple toPlantSimple() {
    return PlantSimple(
      state: state,
      speciesId: speciesId,
      propagationMethod: propagationMethod,
      id: id,
      plantReference: plantReference,
      borrowerId: borrowerId,
      nickname: nickname,
      nbSeedsEnvelope: nbSeedsEnvelope,
      plantingDate: plantingDate,
    );
  }
}
