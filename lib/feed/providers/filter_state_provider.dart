import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/feed/class/filter_state.dart';

class FilterNotifier extends Notifier<FilterState> {
  @override
  FilterState build() {
    return FilterState.empty();
  }

  void setFilterState(FilterState i) {
    state = i;
  }
}

final filterStateProvider = NotifierProvider<FilterNotifier, FilterState>(
  () => FilterNotifier(),
);
