import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/cinema/providers/main_page_index_provider.dart';

class ScrollNotifier extends StateNotifier<double> {
  double startScroll = 0.0;
  ScrollNotifier(double i) : super(i) {
    startScroll = i;
  }

  void setScroll(double event) {
    state = event;
  }

  void reset() {
    state = startScroll;
  }
}

final scrollProvider = StateNotifierProvider<ScrollNotifier, double>((ref) {
  final mainPageIndex = ref.watch(mainPageIndexProvider.notifier);
  return ScrollNotifier(mainPageIndex.startPage.toDouble());
});
