import 'package:flutter_riverpod/flutter_riverpod.dart';

final isAmapAdminProvider = StateNotifierProvider<IsAmapAdminNotifier, bool>((ref) {
  return IsAmapAdminNotifier();
});

class IsAmapAdminNotifier extends StateNotifier<bool> {
  IsAmapAdminNotifier() : super(true);

  void setIsAdmin(bool i) {
    state = i;
  }
}
