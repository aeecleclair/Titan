import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/home/class/event.dart';

final resListProvider = StateNotifierProvider<ResList, List<Event>>((ref) {
  return ResList();
});

class ResList extends StateNotifier<List<Event>> {
  ResList()
      : super([
          Event(
              title: "Réu 1",
              h: 8,
              l: 1,
              color: const Color.fromARGB(255, 35, 146, 72)),
          Event(
              title: "Réu 2",
              h: 9,
              l: 1.5,
              color: const Color.fromARGB(255, 112, 182, 54)),
          Event(
              title: "Réu 3",
              h: 15,
              l: .5,
              color: const Color.fromARGB(255, 37, 140, 149))
        ]);
}
