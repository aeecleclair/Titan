import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class ManagerNotifier extends StateNotifier<Manager> {
  ManagerNotifier() : super(EmptyModels.empty<Manager>());

  void setManager(Manager manager) {
    state = manager;
  }
}

final managerProvider = StateNotifierProvider<ManagerNotifier, Manager>((ref) {
  return ManagerNotifier();
});
