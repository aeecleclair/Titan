import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/class/history_interval.dart';

class SelectedIntervalNotifier extends StateNotifier<HistoryInterval> {
  SelectedIntervalNotifier() : super(HistoryInterval.currentMonth());

  void updateStart(DateTime start) {
    state = HistoryInterval(start, state.end);
  }

  void updateEnd(DateTime end) {
    state = HistoryInterval(state.start, end);
  }

  void clearSelectedInterval() {
    state = HistoryInterval.currentMonth();
  }
}

final selectedIntervalProvider =
    StateNotifierProvider<SelectedIntervalNotifier, HistoryInterval>((ref) {
      return SelectedIntervalNotifier();
    });
