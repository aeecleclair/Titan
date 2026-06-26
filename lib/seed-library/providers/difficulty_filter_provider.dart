import 'package:flutter_riverpod/flutter_riverpod.dart';

final difficultyFilterProvider = NotifierProvider<FilterNotifier, int>(
  FilterNotifier.new,
);

class FilterNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setFilter(int i) {
    state = i;
  }
}
