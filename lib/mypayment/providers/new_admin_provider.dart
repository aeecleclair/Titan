import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class NewAdminNotifier extends Notifier<CoreUserSimple> {
  @override
  CoreUserSimple build() => CoreUserSimple.empty();

  void updateNewAdmin(CoreUserSimple newAdmin) {
    state = newAdmin;
  }

  void resetNewAdmin() {
    state = CoreUserSimple.empty();
  }
}

final newAdminProvider = NotifierProvider<NewAdminNotifier, CoreUserSimple>(
  NewAdminNotifier.new,
);
