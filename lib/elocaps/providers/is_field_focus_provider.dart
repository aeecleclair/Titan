import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsFieldFocustNotifier extends StateNotifier<int> {
  IsFieldFocustNotifier() : super(-1);

  void setFocus(int index) {
    state = index;
  }
}

final isFieldFocusProvider =
    StateNotifierProvider<IsFieldFocustNotifier, int>((ref) {
  return IsFieldFocustNotifier();
});
