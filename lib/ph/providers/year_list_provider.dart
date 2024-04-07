import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';

class YearListNotifier extends StateNotifier<List<int>> {
  YearListNotifier() : super([]);

  void addYear(int year) {
    state.add(year);
  }
}

final yearListProvider =
    StateNotifierProvider<YearListNotifier, List<int>>((ref) {
  final phListNotifier = ref.watch(phListProvider);
  final notifier = phListNotifier.whenData((phList) {
    final yearList = phList.map((ph) => ph.date.year).toSet().toList();
    return YearListNotifier()..state = yearList;
  });
  return notifier.value ?? YearListNotifier();
});
