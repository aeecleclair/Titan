import 'package:flutter_riverpod/flutter_riverpod.dart';

final modifiedProductProvider =
    StateNotifierProvider<ModifiedProductNotifier, int>(
  (ref) {
    return ModifiedProductNotifier();
  },
);

class ModifiedProductNotifier extends StateNotifier<int> {
  ModifiedProductNotifier() : super(-1);

  void setModifiedProduct(int i) {
    state = i;
  }
}
