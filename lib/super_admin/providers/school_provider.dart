import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/super_admin/class/school.dart';
import 'package:titan/super_admin/repositories/school_repository.dart';

class SchoolNotifier extends StateNotifier<School> {
  final SchoolRepository schoolRepository;
  SchoolNotifier({required this.schoolRepository}) : super(School.empty());

  void setSchool(School school) {
    state = school;
  }
}

final schoolProvider = StateNotifierProvider<SchoolNotifier, School>((ref) {
  final schoolRepository = ref.watch(schoolRepositoryProvider);
  return SchoolNotifier(schoolRepository: schoolRepository);
});
