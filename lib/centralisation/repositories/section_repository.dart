import 'package:flutter/gestures.dart';
import 'package:myecl/centralisation/class/section.dart';
import 'package:myecl/tools/repository/repository.dart';

class SectionRepository extends Repository {
  @override
  final host = "https://centralisation.eclair.ec-lyon.fr/links.json";

  Future<List<Section>> getSectionList() async {
    final data = await getList();
    return data.map<Section>((k) => Section.fromJson(k,data[k])).toList();
  }
}