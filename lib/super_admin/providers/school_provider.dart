import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class SchoolNotifier extends Notifier<CoreSchool> {
  @override
  CoreSchool build() {
    return CoreSchool.empty();
  }

  void setSchool(CoreSchool school) {
    state = school;
  }
}

final schoolProvider = NotifierProvider<SchoolNotifier, CoreSchool>(
  SchoolNotifier.new,
);
