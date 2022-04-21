import 'package:flutter_riverpod/flutter_riverpod.dart';

class Page extends StateNotifier<int> {
  Page() : super(0);

  void setPage(int i) {
    state = i;
  }
}

final pageProvider = StateNotifierProvider<Page, int>((ref) {
  return Page();
});
