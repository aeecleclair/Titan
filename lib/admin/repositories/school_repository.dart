import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/school.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';

class SchoolRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "schools/";

  SchoolRepository(super.ref);

  Future<List<School>> getSchoolList() async {
    return List<School>.from((await getList()).map((x) => School.fromJson(x)));
  }

  Future<School> getSchool(String schoolId) async {
    return School.fromJson(await getOne(schoolId));
  }

  Future<bool> deleteSchool(String schoolId) async {
    return await delete(schoolId);
  }

  Future<bool> updateSchool(School school) async {
    return await update(school.toJson(), school.id);
  }

  Future<School> createSchool(School school) async {
    return School.fromJson(await create(school.toJson()));
  }
}

final schoolRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return SchoolRepository(ref)..setToken(token);
});
