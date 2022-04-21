import 'package:flutter_riverpod/flutter_riverpod.dart';

final hasScrolledProvider = StateNotifierProvider<HasScrolled, bool>((ref) {
  return HasScrolled();
});

class HasScrolled extends StateNotifier<bool> {
  HasScrolled() : super(false);

  void setHasScrolled(bool i) {
    state = i;
  }
}
