import 'package:flutter_riverpod/flutter_riverpod.dart';

final difficultyFilterProvider = StateNotifierProvider<FilterNotifier, int>((
  ref,
) {
  return FilterNotifier();
});

class FilterNotifier extends StateNotifier<int> {
  FilterNotifier() : super(0);

  void setFilter(int i) {
    state = i;
  }
}
