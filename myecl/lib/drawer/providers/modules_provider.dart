import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/drawer/class/module.dart';

class ModuleListNotifier extends StateNotifier<List<Module>> {
  ModuleListNotifier([List<Module>? listModule]) : super(listModule ?? []);

  void select(int i) {
    List<Module> r = state.sublist(0);
    // on trouve le produit dans la commande et on change sa quantité
    for (int j = 0; j < r.length; j++) {
      if (i == j) {
        r[i].selected = true;
      } else {
        r[j].selected = false;
      }
    }
    // On met à jour l'état
    state = r;
  }
}

final listModuleProvider =
    StateNotifierProvider<ModuleListNotifier, List<Module>>((ref) {
  return ModuleListNotifier([
    Module(name: "Accueil", icon: Icons.access_alarm, pos: 0, selected: true),
    Module(
        name: "Réservation", icon: Icons.access_alarm, pos: 1, selected: false),
    Module(name: "Prêt", icon: Icons.access_alarm, pos: 2, selected: false),
    Module(name: "Amap", icon: Icons.access_alarm, pos: 3, selected: false),
    Module(name: "Module 6", icon: Icons.access_alarm, pos: 4, selected: false),
    Module(name: "Module 7", icon: Icons.access_alarm, pos: 5, selected: false),
    Module(name: "Module 8", icon: Icons.access_alarm, pos: 6, selected: false),
    Module(name: "Module 9", icon: Icons.access_alarm, pos: 7, selected: false),
    Module(
        name: "Module 10", icon: Icons.access_alarm, pos: 8, selected: false),
  ]);
});
