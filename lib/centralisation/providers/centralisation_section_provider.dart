import 'package:flutter_riverpod/flutter_riverpod.dart';
import'package:myecl/centralisation/class/module.dart';
import 'package:myecl/centralisation/class/section.dart';
import 'package:myecl/centralisation/repositories/section_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SectionNotifier extends StateNotifier<List<Section>> {
  SectionRepository sectionRepository = SectionRepository();
  SectionNotifier() : super([]);

  late List<Section> allSections;
  late List<Module> allModules;
  late List<Module> modulesLiked;

  void initState() async {
    allSections = await sectionRepository.getSectionList();
    for (Section section in allSections) {
      for (Module module in section.module_list) {
        allModules.add(module);
      }
    }
  }

  void get_modules_liked() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      for (Module module in allModules) {
        if (prefs.getBool(module.name) == true) {
          modulesLiked.add(module)
        }
      }
    }
  
  void associer_like(Module m) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(m.name, true);
    m.liked=true;
  }

  void retirer_like(Module m) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(m.name);
    m.liked=false;
  }

  void expande_section(Section s) async {
    s.expanded = true;
  }

  void not_expande_section(Section s) async {
    s.expanded = false;
  }
}