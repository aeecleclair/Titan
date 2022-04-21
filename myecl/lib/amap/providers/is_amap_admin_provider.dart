import 'package:flutter_riverpod/flutter_riverpod.dart';

final isAmapAdminProvider = StateNotifierProvider<IsAmapAdmin, bool>((ref) {
  return IsAmapAdmin();
});

class IsAmapAdmin extends StateNotifier<bool> {
  IsAmapAdmin() : super(true);

  void setIsAdmin(bool i) {
    state = i;
  }
}
