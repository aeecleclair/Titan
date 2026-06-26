import 'package:hooks_riverpod/hooks_riverpod.dart';

class ManagerIdNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void setId(String managerId) {
    state = managerId;
  }
}

final managerIdProvider = NotifierProvider<ManagerIdNotifier, String>(
  ManagerIdNotifier.new,
);
