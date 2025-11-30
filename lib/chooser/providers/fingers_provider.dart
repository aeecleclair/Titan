import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:titan/chooser/class/finger.dart';

/// Nombre d'équipes (par défaut 2).
final numberOfTeamsProvider = StateProvider<int>((ref) => 2);

final fingersProvider = StateNotifierProvider<FingersNotifier, List<Finger>>((
  ref,
) {
  return FingersNotifier();
});

class FingersNotifier extends StateNotifier<List<Finger>> {
  FingersNotifier() : super(const []);

  final Random _random = Random();

  void addFinger(int id, Offset position) {
    // Si le doigt existe déjà, on met à jour sa position
    final index = state.indexWhere((f) => f.id == id);
    if (index != -1) {
      updateFinger(id, position);
      return;
    }

    final color = Colors.primaries[id % Colors.primaries.length];

    state = [...state, Finger(id: id, position: position, color: color)];
  }

  void updateFinger(int id, Offset position) {
    state = [
      for (final f in state)
        if (f.id == id) f.copyWith(position: position) else f,
    ];
  }

  void removeFinger(int id) {
    state = state.where((f) => f.id != id).toList();
  }

  /// Répartit tous les doigts en [teamCount] équipes.
  void assignTeams(int teamCount) {
    if (state.isEmpty) return;

    final validTeamCount = teamCount.clamp(1, state.length);

    final indices = List<int>.generate(state.length, (i) => i)
      ..shuffle(_random);

    final idToTeam = <int, int>{};
    for (var i = 0; i < indices.length; i++) {
      final fingerIndex = indices[i];
      final teamIndex = (i % validTeamCount) + 1; // 1..validTeamCount
      idToTeam[state[fingerIndex].id] = teamIndex;
    }

    state = [
      for (final f in state)
        if (idToTeam.containsKey(f.id))
          f.copyWith(isSelected: true, teamIndex: idToTeam[f.id])
        else
          f.copyWith(isSelected: false, clearTeamIndex: true),
    ];
  }

  void reset() {
    state = const [];
  }
}
