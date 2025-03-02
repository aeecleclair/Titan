import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class SchoolNotifier extends StateNotifier<CoreSchool> {
  SchoolNotifier() : super(CoreSchool.fromJson({}));

  void setSchool(CoreSchool school) {
    state = school;
  }
}

final schoolProvider = StateNotifierProvider<SchoolNotifier, CoreSchool>((ref) {
  return SchoolNotifier();
});
