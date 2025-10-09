import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedYearListNotifier extends StateNotifier<List<int>> {
  SelectedYearListNotifier() : super([DateTime.now().year]);

  void addYear(int year) {
    final copy = List<int>.from(state);
    copy.add(year);
    state = copy;
  }

  void removeYear(int year) {
    final copy = List<int>.from(state);
    copy.remove(year);
    state = copy;
  }
}

final selectedYearListProvider =
    StateNotifierProvider<SelectedYearListNotifier, List<int>>((ref) {
      return SelectedYearListNotifier();
    });
