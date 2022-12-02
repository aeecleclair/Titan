import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/sections_provider.dart';

final selectedPretendanceProvider =
    StateNotifierProvider<SelectedPretendanceProvider, Pretendance>((ref) {
  final pretendanceList = ref.watch(sectionsProvider);
  final prentedances = [];
  pretendanceList.when(
    data: (list) => prentedances.addAll(list),
    error: (e, s) {},
    loading: () {},
  );
  return SelectedPretendanceProvider(prentedances);
});

class SelectedPretendanceProvider extends StateNotifier<Pretendance> {
  SelectedPretendanceProvider(List<dynamic> p) : super(Pretendance.empty());

  void changeSelection(Pretendance s) {
    state = s;
  }

  void clear() {
    state = Pretendance.empty();
  }
}
