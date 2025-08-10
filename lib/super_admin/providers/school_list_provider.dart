import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/super_admin/class/school.dart';
import 'package:titan/super_admin/repositories/school_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class SchoolListNotifier extends ListNotifier<School> {
  final SchoolRepository schoolRepository;
  SchoolListNotifier({required this.schoolRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<School>>> loadSchools() async {
    return await loadList(schoolRepository.getSchoolList);
  }

  Future<bool> createSchool(School school) async {
    return await add(schoolRepository.createSchool, school);
  }

  Future<bool> updateSchool(School school) async {
    return await update(
      schoolRepository.updateSchool,
      (schools, school) =>
          schools..[schools.indexWhere((g) => g.id == school.id)] = school,
      school,
    );
  }

  Future<bool> deleteSchool(School school) async {
    return await delete(
      schoolRepository.deleteSchool,
      (schools, school) => schools..removeWhere((i) => i.id == school.id),
      school.id,
      school,
    );
  }

  void setSchool(School school) {
    state.whenData((d) {
      if (d.indexWhere((g) => g.id == school.id) == -1) return;
      state = AsyncValue.data(
        d..[d.indexWhere((g) => g.id == school.id)] = school,
      );
    });
  }
}

final allSchoolListProvider =
    StateNotifierProvider<SchoolListNotifier, AsyncValue<List<School>>>((ref) {
      final schoolRepository = ref.watch(schoolRepositoryProvider);
      SchoolListNotifier provider = SchoolListNotifier(
        schoolRepository: schoolRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadSchools();
      });
      return provider;
    });
