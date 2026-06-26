import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrollNotifier extends Notifier<double> {
  @override
  double build() {
    return 0;
  }

  void setScroll(double event) {
    state = event;
  }
}

final scrollProvider = NotifierProvider<ScrollNotifier, double>(
  ScrollNotifier.new,
);
