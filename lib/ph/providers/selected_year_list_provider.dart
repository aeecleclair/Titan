import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedYearListNotifier extends Notifier<List<int>> {
  @override
  List<int> build() {
    return [DateTime.now().year];
  }

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
    NotifierProvider<SelectedYearListNotifier, List<int>>(
      SelectedYearListNotifier.new,
    );
