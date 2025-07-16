import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/user/class/simple_users.dart';

class NewAdminNotifier extends StateNotifier<SimpleUser> {
  NewAdminNotifier() : super(SimpleUser.empty());

  void updateNewAdmin(SimpleUser newAdmin) {
    state = newAdmin;
  }

  void resetNewAdmin() {
    state = SimpleUser.empty();
  }
}

final newAdminProvider = StateNotifierProvider<NewAdminNotifier, SimpleUser>((
  ref,
) {
  return NewAdminNotifier();
});
