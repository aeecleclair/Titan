import 'package:flutter_riverpod/flutter_riverpod.dart';
import'package:myecl/centralisation/class/module.dart';
import 'package:myecl/centralisation/class/section.dart';
import 'package:myecl/centralisation/repositories/section_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/auth/providers/openid_provider.dart';


class SectionNotifier extends StateNotifier<List<Section>> {
  SectionRepository sectionRepository = SectionRepository();
  SectionNotifier() : super([]);

  late List<Section> allSections;
  late List<Module> allModules;
  late List<Module> modulesLiked;

  initState() async {
    allSections = await sectionRepository.getSectionList();
    for (Section section in allSections) {
      for (Module module in section.module_list) {
        allModules.add(module);
      }
    }
  }

  void get_module_liked() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      for (Module module in allModules) {
        if (prefs.getBool(module.name) == true) {
          modulesLiked.add(module);
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

final sectionProvider =
    StateNotifierProvider<SectionNotifier , List<Section>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  SectionNotifier notifier = SectionNotifier();
  tokenExpireWrapperAuth(ref, () async {
    await notifier.initState();
  });
  return notifier;
});