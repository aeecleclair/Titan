import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class SchoolListNotifier extends ListNotifierAPI<CoreSchool> {
  Openapi get schoolRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<CoreSchool>> build() {
    loadSchools();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<CoreSchool>>> loadSchools() async {
    return await loadList(schoolRepository.schoolsGet);
  }

  Future<bool> createSchool(CoreSchool school) async {
    return await add(
      () => schoolRepository.schoolsPost(
        body: CoreSchoolBase(name: school.name, emailRegex: school.emailRegex),
      ),
      school,
    );
  }

  Future<bool> updateSchool(CoreSchool school) async {
    return await update(
      () => schoolRepository.schoolsSchoolIdPatch(
        schoolId: school.id,
        body: CoreSchoolUpdate(
          name: school.name,
          emailRegex: school.emailRegex,
        ),
      ),
      (school) => school.id,
      school,
    );
  }

  Future<bool> deleteSchool(CoreSchool school) async {
    return await delete(
      () => schoolRepository.schoolsSchoolIdDelete(schoolId: school.id),
      (school) => school.id,
      school.id,
    );
  }

  void setSchool(CoreSchool school) {
    state.whenData((d) {
      if (d.indexWhere((g) => g.id == school.id) == -1) return;
      state = AsyncValue.data(
        d..[d.indexWhere((g) => g.id == school.id)] = school,
      );
    });
  }
}

final allSchoolListProvider =
    NotifierProvider<SchoolListNotifier, AsyncValue<List<CoreSchool>>>(
      SchoolListNotifier.new,
    );
