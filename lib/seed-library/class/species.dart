import 'dart:core';

import 'package:myecl/seed-library/class/species_type.dart';

class Species {
  final String id; // UUID
  final String prefix; // UUID
  final String name;
  final int difficulty;
  final String? card;
  final int? nbSeedsRecommended;
  final SpeciesType type;
  final DateTime? startSeason;
  final DateTime? endSeason;
  final int? timeMaturation; // in days

  Species({
    required this.id,
    required this.prefix,
    required this.name,
    required this.difficulty,
    required this.type,
    this.card,
    this.nbSeedsRecommended,
    this.startSeason,
    this.endSeason,
    this.timeMaturation,
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'prefix': prefix,
      'name': name,
      'difficulty': difficulty,
      'card': card,
      'nbSeedsRecommended': nbSeedsRecommended,
      'type': type.name,
      'startSeason': startSeason?.toIso8601String(),
      'endSeason': endSeason?.toIso8601String(),
      'timeMaturation': timeMaturation,
    };
  }

  // Create an object from JSON
  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      id: json['id'],
      prefix: json['prefix'],
      name: json['name'],
      difficulty: json['difficulty'],
      card: json['card'],
      nbSeedsRecommended: json['nbSeedsRecommended'],
      type: SpeciesType.fromString(json['type']),
      startSeason: json['startSeason'] != null
          ? DateTime.parse(json['startSeason'])
          : null,
      endSeason:
          json['endSeason'] != null ? DateTime.parse(json['endSeason']) : null,
      timeMaturation: json['timeMaturation'],
    );
  }

  Species.empty()
      : id = '',
        prefix = '',
        name = '',
        difficulty = 0,
        type = SpeciesType.fromString('Unknown'),
        card = null,
        nbSeedsRecommended = null,
        startSeason = null,
        endSeason = null,
        timeMaturation = null;

  Species copyWith({
    String? id,
    String? prefix,
    String? name,
    int? difficulty,
    String? card,
    int? nbSeedsRecommended,
    SpeciesType? type,
    DateTime? startSeason,
    DateTime? endSeason,
    int? timeMaturation,
  }) {
    return Species(
      id: id ?? this.id,
      prefix: prefix ?? this.prefix,
      name: name ?? this.name,
      difficulty: difficulty ?? this.difficulty,
      card: card ?? this.card,
      nbSeedsRecommended: nbSeedsRecommended ?? this.nbSeedsRecommended,
      type: type ?? this.type,
      startSeason: startSeason ?? this.startSeason,
      endSeason: endSeason ?? this.endSeason,
      timeMaturation: timeMaturation ?? this.timeMaturation,
    );
  }

  @override
  String toString() {
    return 'Species(id: $id, prefix: $prefix, name: $name, difficulty: $difficulty, card: $card, nbSeedsRecommended: $nbSeedsRecommended, type: $type, startSeason: $startSeason, endSeason: $endSeason, timeMaturation: $timeMaturation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Species && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
