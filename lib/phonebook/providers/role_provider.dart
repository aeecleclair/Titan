import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/role.dart';


final roleProvider = StateNotifierProvider<RoleProvider, Role>((ref) {
  return RoleProvider();
});

class RoleProvider extends StateNotifier<Role> {
RoleProvider() : super(Role.empty());

  void setRole(Role i) {
    state = i;
  }
}