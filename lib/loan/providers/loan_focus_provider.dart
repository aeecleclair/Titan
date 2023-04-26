import 'package:hooks_riverpod/hooks_riverpod.dart';

class FocusNotifier extends StateNotifier<bool> {
  FocusNotifier() : super(false);

  void setFocus(bool value) {
    state = value;
  }
}

final loanFocusProvider = StateNotifierProvider<FocusNotifier, bool>((ref) {
  return FocusNotifier();
});
