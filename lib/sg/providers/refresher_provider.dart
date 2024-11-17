import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshNotifier extends StateNotifier<bool> {
  RefreshNotifier() : super(false);

  void setState() {
    state = !state;
  }
}

final refreshProvider = StateNotifierProvider<RefreshNotifier, bool>((ref) {
  return RefreshNotifier();
});
