import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/home/class/event.dart';

final resListProvider =
    StateNotifierProvider<ResListNotifier, List<Event>>((ref) {
  return ResListNotifier();
});

class ResListNotifier extends StateNotifier<List<Event>> {
  ResListNotifier()
      : super([
          Event(
              title: "Réu 1",
              color: const Color.fromARGB(255, 35, 146, 72),
              endTime: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 9, 0),
              startTime: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 8, 0)),
          Event(
              title: "Réu 2",
              color: const Color.fromARGB(255, 112, 182, 54),
              endTime: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 10, 30),
              startTime: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 9, 0),

              ),
          Event(
              title: "Réu 3",
              color: const Color.fromARGB(255, 37, 140, 149),
              endTime: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 15, 30),
              startTime: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 15, 0)),
        ]);
}
