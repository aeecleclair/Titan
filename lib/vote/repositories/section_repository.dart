import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/vote/class/section.dart';

class SectionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "campaign/sections";

  Future<Section> getSection(String sectionId) async {
    return Section.fromJson(await getOne("/$sectionId"));
  }

  Future<bool> deleteSection(String sectionId) async {
    return await delete("/$sectionId");
  }

  Future<bool> updateSection(Section section) async {
    return await update(section.toJson(), "/${section.id}");
  }

  Future<Section> createSection(Section section) async {
    return Section.fromJson(await create(section.toJson()));
  }

  Future<List<Section>> getSections() async {
    return (await getList()).map((e) => Section.fromJson(e)).toList();
  }
}

final sectionRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return SectionRepository()..setToken(token);
});
