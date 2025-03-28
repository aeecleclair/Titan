import 'package:flutter_riverpod/flutter_riverpod.dart';

final consumedFilterProvider = StateNotifierProvider<BoolNotifier, bool>((ref) {
  return BoolNotifier();
});

class BoolNotifier extends StateNotifier<bool> {
  BoolNotifier() : super(false);

  void setBool(bool i) {
    state = i;
  }
}
