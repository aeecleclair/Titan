import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/class/history_interval.dart';

class SelectedIntervalNotifier extends Notifier<HistoryInterval> {
  @override
  HistoryInterval build() {
    return HistoryInterval.currentMonth();
  }

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
    NotifierProvider<SelectedIntervalNotifier, HistoryInterval>(
      SelectedIntervalNotifier.new,
    );
