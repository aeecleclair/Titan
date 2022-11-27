import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/event/providers/is_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

final modulesProvider =
    StateNotifierProvider<ModulesNotifier, List<Module>>((ref) {
  final eventAdmin = ref.watch(isEventAdmin);
  ModulesNotifier modulesNotifier = ModulesNotifier();
  modulesNotifier.loadModules([ModuleType.event], [eventAdmin]).then((value) {
    modulesNotifier.setFirstPage();
    return modulesNotifier;
  });
  return modulesNotifier;
});

class ModulesNotifier extends StateNotifier<List<Module>> {
  String dbModule = "modules";
  List<Module> allModules = [
    Module(
        name: "Calendrier",
        icon: HeroIcons.calendarDays,
        page: ModuleType.home,
        selected: false),
    Module(
        name: "Réservation",
        icon: HeroIcons.tableCells,
        page: ModuleType.booking,
        selected: false),
    Module(
        name: "Prêt",
        icon: HeroIcons.buildingLibrary,
        page: ModuleType.loan,
        selected: false),
    Module(
        name: "Amap",
        icon: HeroIcons.shoppingCart,
        page: ModuleType.amap,
        selected: false),
    Module(
        name: "Évenements",
        icon: HeroIcons.calendar,
        page: ModuleType.event,
        selected: false),
    Module(
        name: "Vote",
        icon: HeroIcons.envelopeOpen,
        page: ModuleType.vote,
        selected: false),
    Module(
        name: "Cinéma",
        icon: HeroIcons.ticket,
        page: ModuleType.cinema,
        selected: false),
  ];
  ModulesNotifier() : super([]);

  void saveModules() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList(
          dbModule, state.map((e) => e.page.toString()).toList());
    });
  }

  Future loadModules(List<ModuleType> types, List<bool> canSee) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> modulesName = prefs.getStringList(dbModule) ?? [];
    if (modulesName.isEmpty) {
      modulesName = allModules.map((e) => e.page.toString()).toList();
      prefs.setStringList(dbModule, modulesName);
    }
    List<Module> modules = [];
    final allmodulesName = allModules.map((e) => e.page.toString()).toList();
    for (String name in modulesName) {
      if (allmodulesName.contains(name)) {
        if (types.contains(ModuleType.values[allmodulesName.indexOf(name)])) {
          if (canSee[
              types.indexOf(ModuleType.values[allmodulesName.indexOf(name)])]) {
            modules.add(allModules[allmodulesName.indexOf(name)]);
          }
        } else {
          modules.add(allModules[allmodulesName.indexOf(name)]);
        }
      }
    }
    state = modules;
  }

  void filterModules(ModuleType type, bool canSee) {
    List<Module> r = state.sublist(0);
    for (Module m in r) {
      if (m.page == type && !canSee) {
        r.remove(m);
      }
    }
    state = r;
  }

  void reorderModules(int oldIndex, int newIndex) {
    List<Module> r = state.sublist(0);
    Module module = r.removeAt(oldIndex);
    r.insert(newIndex, module);
    state = r;
  }

  void setFirstPage() {
    if (state.isNotEmpty) {
      List<Module> r = state.sublist(0);
      r[0].selected = true;
      state = r;
    }
  }

  void toggleModule(Module m) {
    List<Module> r = state.sublist(0);
    if (r.contains(m)) {
      r.remove(m);
    } else {
      r.add(m);
    }
    state = r;
  }
}
