import 'package:flutter_riverpod/flutter_riverpod.dart';

final seasonFilterProvider =
    StateNotifierProvider<FilterNotifier, String>((ref) {
  return FilterNotifier();
});

class FilterNotifier extends StateNotifier<String> {
  FilterNotifier() : super("toutes");

  void setFilter(String i) {
    state = i;
  }
}
