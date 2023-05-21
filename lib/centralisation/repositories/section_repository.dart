import 'package:myecl/centralisation/class/section.dart';
import 'package:myecl/tools/repository/repository.dart';

class SectionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final host = "https://centralisation.eclair.ec-lyon.fr/links.json";

  Future<List<Section>> getSectionList() async {
    final Map<dynamic, dynamic> data = await getOne("");
    List<Section> modules = [];
    data.forEach((key, value) {
      modules.add(Section.fromJson(key, value));
    });
    return modules;
  }
}