import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class ManagerNotifier extends StateNotifier<Manager> {
  ManagerNotifier() : super(Manager.fromJson({}));

  void setManager(Manager manager) {
    state = manager;
  }
}

final managerProvider = StateNotifierProvider<ManagerNotifier, Manager>((ref) {
  return ManagerNotifier();
});
