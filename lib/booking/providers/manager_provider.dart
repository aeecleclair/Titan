import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/booking/class/manager.dart';

class ManagerNotifier extends StateNotifier<Manager> {
  ManagerNotifier() : super(Manager.empty());

  void setManager(Manager manager) {
    state = manager;
  }
}

final managerProvider = StateNotifierProvider<ManagerNotifier, Manager>((ref) {
  return ManagerNotifier();
});
