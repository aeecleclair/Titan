import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class SchoolNotifier extends StateNotifier<CoreSchool> {
  SchoolNotifier() : super(EmptyModels.empty<CoreSchool>());

  void setSchool(CoreSchool school) {
    state = school;
  }
}

final schoolProvider = StateNotifierProvider<SchoolNotifier, CoreSchool>((ref) {
  return SchoolNotifier();
});
