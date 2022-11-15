import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPageIndexNotifier extends StateNotifier<int> {
  MainPageIndexNotifier() : super(0);

  void setMainPageIndex(int event) {
    state = event;
  }
}

final mainPageIndexProvider =
    StateNotifierProvider<MainPageIndexNotifier, int>((ref) {
  return MainPageIndexNotifier();
});
