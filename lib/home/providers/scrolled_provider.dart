import 'package:flutter_riverpod/flutter_riverpod.dart';

final hasScrolledProvider = StateNotifierProvider<HasScrolledNotifier, bool>((
  ref,
) {
  return HasScrolledNotifier();
});

class HasScrolledNotifier extends StateNotifier<bool> {
  HasScrolledNotifier() : super(false);

  void setHasScrolled(bool i) {
    state = i;
  }
}
