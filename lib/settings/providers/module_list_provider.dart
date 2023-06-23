import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:collection/collection.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final modulesProvider =
    StateNotifierProvider<ModulesNotifier, List<Module>>((ref) {
  final me = ref.watch(userProvider);
  final isAEMember = me.groups
      .map((e) => e.id)
      .contains("39691052-2ae5-4e12-99d0-7a9f5f2b0136");
  ModulesNotifier modulesNotifier = ModulesNotifier();
  modulesNotifier.loadModules([ModuleType.amap],
      [isAEMember]); // TODO: rebloquer le vote pour les non AE
  return modulesNotifier;
});

class ModulesNotifier extends StateNotifier<List<Module>> {
  String dbModule = "modules";
  String dbAllModules = "allModules";
  final eq = const DeepCollectionEquality.unordered();
  List<Module> allModules = [
    Module(
        name: "Calendrier",
        icon: HeroIcons.calendarDays,
        page: ModuleType.amap,
        selected: false),
    Module(
        name: "Réservation",
        icon: HeroIcons.tableCells,
        page: ModuleType.amap,
        selected: false),
    Module(
        name: "Prêt",
        icon: HeroIcons.buildingLibrary,
        page: ModuleType.amap,
        selected: false),
    Module(
        name: "Amap",
        icon: HeroIcons.shoppingCart,
        page: ModuleType.amap,
        selected: false),
    Module(
        name: "Tombola",
        icon: HeroIcons.gift,
        page: ModuleType.tombola,
        selected: false),
    Module(
        name: "Évenements",
        icon: HeroIcons.calendar,
        page: ModuleType.amap,
        selected: false),
    Module(
        name: "Vote",
        icon: HeroIcons.envelopeOpen,
        page: ModuleType.amap,
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
    if (modulesName.isEmpty) {
      modulesName = allmodulesName;
      saveModules();
    }
    if (allModulesName.isEmpty || !eq.equals(allModulesName, allmodulesName)) {
      allModulesName = allmodulesName;
      modulesName = allmodulesName;
      saveAllModules();
      saveModules();
    } else {
      allModules.sort((a, b) => allModulesName
          .indexOf(a.page.toString())
          .compareTo(allModulesName.indexOf(b.page.toString())));
      modulesName.sort((a, b) =>
          allModulesName.indexOf(a).compareTo(allModulesName.indexOf(b)));
    }
    List<Module> modules = [];
    List<Module> toDelete = [];
    for (String name in modulesName) {
      if (allmodulesName.contains(name)) {
        Module module = allModules[allModulesName.indexOf(name)];
        if (types.contains(module.page)) {
          if (canSee[types.indexOf(module.page)]) {
            modules.add(module);
          } else {
            toDelete.add(module);
          }
        } else {
          modules.add(module);
        }
      }
    }
    for (Module module in toDelete) {
      allModules.remove(module);
    }
    state = modules;
  }

  void sortModules() {
    final allmodulesName = allModules.map((e) => e.page.toString()).toList();
    final sorted = state.sublist(0)
      ..sort((a, b) => allmodulesName
          .indexOf(a.page.toString())
          .compareTo(allmodulesName.indexOf(b.page.toString())));
    state = sorted;
    saveModules();
  }

  ModuleType getFirstPage() {
    if (state.isNotEmpty) {
      return state[0].page;
    } else {
      return ModuleType.amap;
    }
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
    sortModules();
    saveModules();
  }
}
