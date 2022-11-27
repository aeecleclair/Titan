import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/event/providers/is_admin.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

final modulesProvider =
    StateNotifierProvider<ModulesNotifier, List<Module>>((ref) {
  final eventAdmin = ref.watch(isEventAdmin);
  ModulesNotifier modulesNotifier = ModulesNotifier();
  modulesNotifier.loadModules([ModuleType.event], [eventAdmin]);
  return modulesNotifier;
});

final firstPageProvider = Provider<ModuleType>((ref) {
  final modules = ref.watch(modulesProvider);
  if (modules.isNotEmpty) {
    return modules.first.page;
  } else {
    return ModuleType.home;
  }
});
class ModulesNotifier extends StateNotifier<List<Module>> {
  String dbModule = "modules";
  String dbAllModules = "allModules";
  final eq = const DeepCollectionEquality.unordered();
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
      prefs.remove(dbModule);
      prefs.setStringList(
          dbModule, state.map((e) => e.page.toString()).toList());
    });
  }

  void saveAllModules() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(dbAllModules);
      prefs.setStringList(
          dbAllModules, allModules.map((e) => e.page.toString()).toList());
    });
  }

  Future loadModules(List<ModuleType> types, List<bool> canSee) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> modulesName = prefs.getStringList(dbModule) ?? [];
    List<String> allModulesName = prefs.getStringList(dbAllModules) ?? [];
    final allmodulesName = allModules.map((e) => e.page.toString()).toList();
    if (allModulesName.isEmpty || !eq.equals(allModulesName, allmodulesName)) {
      prefs.setStringList(dbAllModules, allmodulesName);
    } else {
      allModules.sort((a, b) => allModulesName
          .indexOf(a.page.toString())
          .compareTo(allModulesName.indexOf(b.page.toString())));
    }
    if (modulesName.isEmpty) {
      modulesName = allmodulesName;
      prefs.setStringList(dbModule, modulesName);
    }
    List<Module> modules = [];
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
    if (state.isNotEmpty) {
      modules[0].selected = true;
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
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    allModules.insert(newIndex, allModules.removeAt(oldIndex));
    final moduesIds = state.map((e) => e.page.toString()).toList();
    state =
        allModules.where((e) => moduesIds.contains(e.page.toString())).toList();
    saveAllModules();
  }

  void toggleModule(Module m) {
    List<Module> r = state.sublist(0);
    if (r.contains(m)) {
      r.remove(m);
    } else {
      r.add(m);
    }
    state = r;
    saveModules();
  }
}
