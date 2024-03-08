import 'package:myecl/centralisation/class/section.dart';
import 'package:myecl/tools/repository/repository.dart';

class SectionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final host = "https://centralisation.eclair.ec-lyon.fr/links.json";

  Future<List<Section>> getSectionList() async {
    final data = await getOne("", decode: true)
        as Map<String, List<Map<String, dynamic>>>;
    return data
        .map((key, value) => MapEntry(key, Section.fromJson(key, value)))
        .values
        .toList();
  }
}
