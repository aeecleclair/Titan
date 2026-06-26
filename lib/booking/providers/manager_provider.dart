import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class ManagerNotifier extends Notifier<Manager> {
  @override
  Manager build() {
    return Manager.empty();
  }

  void setManager(Manager manager) {
    state = manager;
  }
}

final managerProvider = NotifierProvider<ManagerNotifier, Manager>(
  ManagerNotifier.new,
);
