import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsFieldFocusNotifier extends StateNotifier<int> {
  IsFieldFocusNotifier() : super(-1);

  void setFocus(int index) {
    state = index;
  }
}

final isFieldFocusProvider =
    StateNotifierProvider<IsFieldFocusNotifier, int>((ref) {
  return IsFieldFocusNotifier();
});
