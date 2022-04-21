import 'package:flutter_riverpod/flutter_riverpod.dart';

final isAdminProvider = StateNotifierProvider<IsAdmin, bool>((ref) {
  return IsAdmin();
});

class IsAdmin extends StateNotifier<bool> {
  IsAdmin() : super(true);

  void setIsAdmin(bool i) {
    state = i;
  }
}
