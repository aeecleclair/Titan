import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectedMonthNotifier extends StateNotifier<DateTime> {
  SelectedMonthNotifier() : super(DateTime(DateTime.now().year, DateTime.now().month));

  void updateSelectedMonth(DateTime selectedMonth) {
    state = selectedMonth;
  }
}

final selectedMonthProvider =
    StateNotifierProvider<SelectedMonthNotifier, DateTime>((ref) {
  return SelectedMonthNotifier();
});
