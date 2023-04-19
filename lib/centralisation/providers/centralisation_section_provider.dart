import 'package:flutter_riverpod/flutter_riverpod.dart';
import'package:myecl/centralisation/class/module.dart';
import 'package:myecl/centralisation/class/section.dart';
import 'package:myecl/centralisation/repositories/module_repository.dart';
import 'package:myecl/centralisation/repositories/section_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';


class SectionNotifier extends StateNotifier<List<Section>> {
  final eq = const DeepCollectionEquality.unordered();
  SectionRepository sectionRepository = SectionRepository();
  SectionNotifier() : super([]);

  late Future<List<Section>> allSections;

  void initState() {
    allSections = sectionRepository.getSectionList();
  }

}
class ModuleNotifier extends StateNotifier<List<Module>> {
  String dbModule = "modules";
  String dbAllModules = "allModules";
  final eq = const DeepCollectionEquality.unordered();
  ModuleRepository moduleRepository = ModuleRepository();
  ModuleNotifier() : super([]);

  late Future<List<Module>> allModules;

  void initState() {
    allModules = moduleRepository.getModuleList();
  }

  void associer_like(Module m) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(m.name, true);
  }
}