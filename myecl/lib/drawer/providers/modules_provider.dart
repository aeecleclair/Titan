import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/drawer/class/module.dart';

class ModuleListNotifier extends StateNotifier<List<Module>> {
  ModuleListNotifier([List<Module>? listModule]) : super(listModule ?? []);

  void select(int i) {
    List<Module> r = state.sublist(0);

    for (int j = 0; j < r.length; j++) {
      if (i == j) {
        r[i].selected = true;
      } else {
        r[j].selected = false;
      }
    }

    state = r;
  }
}

final listModuleProvider =
    StateNotifierProvider<ModuleListNotifier, List<Module>>((ref) {
  return ModuleListNotifier([
    Module(name: "Accueil", icon: Icons.access_alarm, pos: 1, selected: true),
    Module(
        name: "Réservation", icon: Icons.access_alarm, pos: 2, selected: false),
    Module(name: "Prêt", icon: Icons.access_alarm, pos: 3, selected: false),
    Module(name: "Amap", icon: Icons.access_alarm, pos: 4, selected: false),
  ]);
});
