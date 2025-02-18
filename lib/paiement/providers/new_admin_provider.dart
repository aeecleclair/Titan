import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/user/class/list_users.dart';

class NewAdminNotifier extends StateNotifier<SimpleUser> {
  NewAdminNotifier() : super(SimpleUser.empty());

  void updateNewAdmin(SimpleUser newAdmin) {
    state = newAdmin;
  }
}

final newAdminProvider =
    StateNotifierProvider<NewAdminNotifier, SimpleUser>((ref) {
  return NewAdminNotifier();
});
