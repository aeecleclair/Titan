import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageNotifier extends StateNotifier<int> {
  PageNotifier() : super(1);

  void setSortingType(int i) {
    state = i;
  }
}

final pageProvider = StateNotifierProvider<PageNotifier, int>((ref) {
  return PageNotifier();
});
