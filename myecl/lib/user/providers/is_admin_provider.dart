import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final isAdminProvider =
    StateNotifierProvider<IsAdminNotifier, bool>((ref) {
  return IsAdminNotifier();
});

class IsAdminNotifier extends StateNotifier<bool> {
  IsAdminNotifier() : super(true);

  void setIsAdmin(bool i) {
    state = i;
  }
}
