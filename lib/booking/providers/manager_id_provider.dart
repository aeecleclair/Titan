import 'package:hooks_riverpod/hooks_riverpod.dart';

class ManagerIdNotifier extends StateNotifier<String> {
  ManagerIdNotifier() : super("");

  void setId(String managerId) {
    state = managerId;
  }
}

final managerIdProvider = StateNotifierProvider<ManagerIdNotifier, String>((
  ref,
) {
  return ManagerIdNotifier();
});
