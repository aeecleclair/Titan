import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/rplace/class/focus.dart';

class FocusNotifier extends StateNotifier<PixelFocus> {
  FocusNotifier() : super(PixelFocus.empty());

  void setPixelFocus(PixelFocus i) {
    state = i;
  }

  void unfocus() {
    state = PixelFocus.empty();
  }
}

final focusProvider = StateNotifierProvider<FocusNotifier, PixelFocus>((ref) {
  return FocusNotifier();
});
