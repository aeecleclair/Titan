import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrollNotifier extends StateNotifier<double> {
  ScrollNotifier() : super(0);

  void setScroll(double event) {
    state = event;
  }
}

final scrollProvider = StateNotifierProvider<ScrollNotifier, double>((ref) {
  return ScrollNotifier();
});
