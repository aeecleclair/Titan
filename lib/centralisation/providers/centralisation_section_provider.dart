import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/centralisation/class/module.dart';
import 'package:myecl/centralisation/class/section.dart';
import 'package:myecl/centralisation/repositories/section_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class SectionNotifier extends StateNotifier<List<Section>> {
  SectionRepository sectionRepository = SectionRepository();
  SectionNotifier() : super([]);

  late List<Section> allSections;
  late List<Module> allModules;
  late List<Module> modulesLiked;

  initState() async {
    allSections = await sectionRepository.getSectionList();
    for (Section section in allSections) {
      for (Module module in section.moduleList) {
        allModules.add(module);
      }
    }
  }

  void getLikedModule() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (Module module in allModules) {
      if (prefs.getBool(module.name) == true) {
        modulesLiked.add(module);
        modulesLiked.add(module);
      }
    }
  }

  void associateLike(Module m) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(m.name, true);
    m.liked = true;
  }

  void removeLike(Module m) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(m.name);
    m.liked = false;
  }

  void expandSection(Section s) async {
    s.expanded = true;
  }

  void contractSection(Section s) async {
    s.expanded = false;
  }
}

final sectionProvider =
    StateNotifierProvider<SectionNotifier, List<Section>>((ref) {
  SectionNotifier notifier = SectionNotifier();
  tokenExpireWrapperAuth(ref, () async {
    await notifier.initState();
  });
  return notifier;
});
