import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/ph/providers/ph_list_provider.dart';

class YearListNotifier extends Notifier<List<int>> {
  @override
  List<int> build() {
    final phList = ref.watch(phListProvider);
    return phList.whenData((phList) {
          final yearList = phList
              .map((ph) => ph.releaseDate.year)
              .toSet()
              .toList();
          return yearList;
        }).value ??
        [];
  }

  void addYear(int year) {
    state.add(year);
  }
}

final yearListProvider = NotifierProvider<YearListNotifier, List<int>>(
  YearListNotifier.new,
);
