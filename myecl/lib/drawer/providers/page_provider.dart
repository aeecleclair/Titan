import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageNotifier extends StateNotifier<int> {
  PageNotifier() : super(4);

  void setPage(int i) {
    state = i;
  }
}

final pageProvider = StateNotifierProvider<PageNotifier, int>((ref) {
  return PageNotifier();
});
