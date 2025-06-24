import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/ph/providers/ph_list_provider.dart';

class YearListNotifier extends StateNotifier<List<int>> {
  YearListNotifier(super.year);

  void addYear(int year) {
    state.add(year);
  }
}

final yearListProvider = StateNotifierProvider<YearListNotifier, List<int>>((
  ref,
) {
  final phList = ref.watch(phListProvider);
  final notifier = phList.whenData((phList) {
    final yearList = phList.map((ph) => ph.date.year).toSet().toList();
    return YearListNotifier(yearList);
  });
  return notifier.value ?? YearListNotifier([]);
});
