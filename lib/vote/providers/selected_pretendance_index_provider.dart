import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedPretendanceIndexProvider =
    StateNotifierProvider<SelectedPretendance, int>((ref) {
  return SelectedPretendance();
});

class SelectedPretendance extends StateNotifier<int> {
  SelectedPretendance() : super(0);

  void setSelectedPretendance(int i) {
    state = i;
  }
}
