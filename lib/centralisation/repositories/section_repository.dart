import 'package:myecl/centralisation//class/module.dart';
import 'package:myecl/centralisation//class/section.dart';
import 'package:myecl/tools/repository/repository.dart';

class SectionRepository extends Repository {
  @override
  final String host = "https://centralisation.eclair.ec-lyon.fr/links.json";

  Future<List<Section>> getSectionList() async {
    final Map<dynamic, dynamic> data = await getOne("");
    List<Section> sections = [];

    data.forEach((key, value) {
      List<Module> modules = [];
      value['modules'].forEach((moduleData) {
        modules.add(Module.fromJson(moduleData as Map<String, dynamic>));
      });

      final section = Section.fromJson(value as Map<String, dynamic>);
      section.modules = modules;
      sections.add(section);
    });

    return sections;
  }
}