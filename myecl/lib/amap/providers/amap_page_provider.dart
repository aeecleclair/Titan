import 'package:flutter_riverpod/flutter_riverpod.dart';

final amapPageProvider = StateNotifierProvider<AmapPageNotifier, int>((ref) {
  return AmapPageNotifier();
});

class AmapPageNotifier extends StateNotifier<int> {
  AmapPageNotifier() : super(0);

  void setAmapPage(int i) {
    state = i;
  }
}
