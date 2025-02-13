import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/utils.dart';

class SelectedSortingScoreTimeNotifier extends StateNotifier<Period> {
  SelectedSortingScoreTimeNotifier() : super(Period.always);

  void setSortingPeriod(Period p) {
    state = p;
  }
}

final selectedSortingScoreTimeProvider =
    StateNotifierProvider<SelectedSortingScoreTimeNotifier, Period>((ref) {
  return SelectedSortingScoreTimeNotifier();
});
