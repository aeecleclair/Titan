import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/home/class/event.dart';

final resListProvider =
    StateNotifierProvider<ResListNotifier, List<Event>>((ref) {
  return ResListNotifier();
});

class ResListNotifier extends StateNotifier<List<Event>> {
  ResListNotifier()
      : super([]);
}
