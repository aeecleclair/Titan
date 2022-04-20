import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/home/class/res.dart';

/// Le provider de l'index de la ResList affichée
final resListProvider = StateNotifierProvider<ResList, List<Res>>((ref) {
  return ResList();
});

class ResList extends StateNotifier<List<Res>> {
  // Par défaut, la ResList principale
  ResList() : super(
    [
    Res(
        title: "Réu 1",
        h: 8,
        l: 1,
        color: const Color.fromARGB(255, 35, 146, 72)),
    Res(
        title: "Réu 2",
        h: 9,
        l: 1.5,
        color: const Color.fromARGB(255, 112, 182, 54)),
    Res(
        title: "Réu 3",
        h: 15,
        l: .5,
        color: const Color.fromARGB(255, 37, 140, 149))
  ]
  );
}
