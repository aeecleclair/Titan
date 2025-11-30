import 'package:flutter/material.dart';

class Finger {
  Finger({
    required this.id,
    required this.position,
    required this.color,
    this.isSelected = false,
    this.teamIndex,
  });

  final int id;
  final Offset position;
  final Color color;
  final bool isSelected;

  /// Numéro d'équipe (1, 2, ..., N) ou null si pas d'équipe.
  final int? teamIndex;

  Finger copyWith({
    Offset? position,
    Color? color,
    bool? isSelected,
    int? teamIndex,
    bool clearTeamIndex = false,
  }) {
    return Finger(
      id: id,
      position: position ?? this.position,
      color: color ?? this.color,
      isSelected: isSelected ?? this.isSelected,
      teamIndex: clearTeamIndex ? null : (teamIndex ?? this.teamIndex),
    );
  }
}
