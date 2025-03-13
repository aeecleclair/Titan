import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchFilterProvider =
    StateNotifierProvider<FilterNotifier, String>((ref) {
  return FilterNotifier();
});

class FilterNotifier extends StateNotifier<String> {
  FilterNotifier() : super("");

  void setFilter(String i) {
    state = i;
  }
}
