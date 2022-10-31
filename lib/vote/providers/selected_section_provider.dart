import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedSectionProvider =
    StateNotifierProvider<SelectedSection, int>((ref) {
  return SelectedSection();
});

class SelectedSection extends StateNotifier<int> {
  SelectedSection() : super(0);

  void setSelectedSection(int i) {
    state = i;
  }
}
