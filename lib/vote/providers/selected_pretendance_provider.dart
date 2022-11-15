import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/vote/providers/sections_provider.dart';

final selectedPretendanceProvider =
    StateNotifierProvider<SelectedPretendanceProvider, List<String>>((ref) {
  final pretendanceList = ref.watch(sectionsProvider);
  final prentedances = [];
  pretendanceList.when(
    data: (list) => prentedances.addAll(list),
    error: (e, s) {},
    loading: () {},
  );
  return SelectedPretendanceProvider(prentedances);
});

class SelectedPretendanceProvider extends StateNotifier<List<String>> {
  SelectedPretendanceProvider(List<dynamic> p)
      : super(List.generate(p.length, (index) => ""));

  void changeSelection(int i, String s) {
    var copy = state.toList();
    copy[i] = s;
    state = copy;
  }

  void clear() {
    state = List.generate(state.length, (index) => "");
  }
}
