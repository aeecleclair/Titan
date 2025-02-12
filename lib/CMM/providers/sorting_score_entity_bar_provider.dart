import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/utils.dart';

class SelectedSortingScoreNotifier extends StateNotifier<Period> {
  SelectedSortingScoreNotifier() : super(Period.always);

  void setSortingPeriod(Period p) {
    state = p;
  }
}

final selectedSortingScoreProvider =
    StateNotifierProvider<SelectedSortingScoreNotifier, Period>((ref) {
  return SelectedSortingScoreNotifier();
});
