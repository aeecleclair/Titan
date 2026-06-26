import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/cinema/providers/main_page_index_provider.dart';

class ScrollNotifier extends Notifier<double> {
  double startScroll = 0.0;

  @override
  double build() {
    final mainPageIndex = ref.watch(mainPageIndexProvider.notifier);
    startScroll = mainPageIndex.startPage.toDouble();
    return startScroll;
  }

  void setScroll(double event) {
    state = event;
  }

  void reset() {
    state = startScroll;
  }
}

final scrollProvider = NotifierProvider<ScrollNotifier, double>(
  ScrollNotifier.new,
);
