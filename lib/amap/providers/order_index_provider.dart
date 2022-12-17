import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderIndexProvider =
    StateNotifierProvider<OrderIndexNotifier, int>((ref) {
  return OrderIndexNotifier();
});

class OrderIndexNotifier extends StateNotifier<int> {
  OrderIndexNotifier() : super(-1);

  void setIndex(int i) {
    state = i;
  }
}
