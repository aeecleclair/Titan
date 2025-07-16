import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/user/class/simple_users.dart';

class NewSuperAdminNotifier extends StateNotifier<SimpleUser> {
  NewSuperAdminNotifier() : super(SimpleUser.empty());

  void updateNewSuperAdmin(SimpleUser newSuperAdmin) {
    state = newSuperAdmin;
  }

  void resetNewSuperAdmin() {
    state = SimpleUser.empty();
  }
}

final newSuperAdminProvider =
    StateNotifierProvider<NewSuperAdminNotifier, SimpleUser>((ref) {
      return NewSuperAdminNotifier();
    });
