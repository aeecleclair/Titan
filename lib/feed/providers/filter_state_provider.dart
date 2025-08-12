import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/feed/class/filter_state.dart';

class FilterStateNotifier extends StateNotifier<FilterState> {
  FilterStateNotifier() : super(FilterState.empty());

  void setFilterState(FilterState i) {
    state = i;
  }
}

final filterStateProvider =
    StateNotifierProvider<FilterStateNotifier, FilterState>((ref) {
      return FilterStateNotifier();
    });
