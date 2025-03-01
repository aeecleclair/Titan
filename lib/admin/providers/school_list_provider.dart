import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/admin/adapters/school.dart';

class SchoolListNotifier extends ListNotifierAPI<CoreSchool> {
  final Openapi schoolRepository;
  SchoolListNotifier({required this.schoolRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<CoreSchool>>> loadSchools() async {
    return await loadList(schoolRepository.schoolsGet);
  }

  Future<bool> createSchool(CoreSchoolBase school) async {
    return await add(() => schoolRepository.schoolsPost(body: school), school);
  }

  Future<bool> updateSchool(CoreSchool school) async {
    return await update(
      () => schoolRepository.schoolsSchoolIdPatch(
        schoolId: school.id,
        body: school.toCoreSchoolUpdate(),
      ),
      (school) => school.id,
      school,
    );
  }

  Future<bool> deleteSchool(CoreSchool school) async {
    return await delete(
      () => schoolRepository.schoolsSchoolIdDelete(schoolId: school.id),
      (schools) => schools..removeWhere((i) => i.id == school.id),
    );
  }

  void setSchool(CoreSchool school) {
    state.whenData(
      (d) {
        if (d.indexWhere((g) => g.id == school.id) == -1) return;
        state = AsyncValue.data(
          d..[d.indexWhere((g) => g.id == school.id)] = school,
        );
      },
    );
  }
}

final allSchoolListProvider =
    StateNotifierProvider<SchoolListNotifier, AsyncValue<List<CoreSchool>>>(
        (ref) {
  final schoolRepository = ref.watch(repositoryProvider);
  SchoolListNotifier provider =
      SchoolListNotifier(schoolRepository: schoolRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadSchools();
  });
  return provider;
});
