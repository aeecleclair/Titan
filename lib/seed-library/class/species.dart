import 'dart:core';

import 'package:titan/seed-library/class/species_type.dart';
import 'package:titan/tools/functions.dart';

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
      'nb_seeds_recommended': nbSeedsRecommended,
      'species_type': type.name,
      'start_season': startSeason != null
          ? processDateToAPIWithoutHour(startSeason!)
          : null,
      'end_season': endSeason != null
          ? processDateToAPIWithoutHour(endSeason!)
          : null,
      'time_maturation': timeMaturation,
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
      nbSeedsRecommended: json['nb_seeds_recommended'],
      type: SpeciesType.fromString(json['species_type']),
      startSeason: json['start_season'] != null
          ? processDateFromAPIWithoutHour(json['start_season'])
          : null,
      endSeason: json['end_season'] != null
          ? processDateFromAPIWithoutHour(json['end_season'])
          : null,
      timeMaturation: json['time_maturation'],
    );
  }

  Species.empty()
    : id = '',
      prefix = '',
      name = '',
      difficulty = 0,
      type = SpeciesType.empty(),
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
}
