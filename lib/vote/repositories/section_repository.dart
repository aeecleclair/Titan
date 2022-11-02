import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/vote/class/section.dart';

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
    return await update(section, "/${section.id}");
  }

  Future<Section> createSection(Section section) async {
    return Section.fromJson(await create(section));
  }

  Future<List<Section>> getSections() async {
    return (await getList()).map((e) => Section.fromJson(e)).toList();
  }
}
