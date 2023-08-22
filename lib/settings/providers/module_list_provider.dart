import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/ui/router.dart';
import 'package:myecl/admin/providers/all_my_module_roots_list_provider.dart';
import 'package:myecl/amap/router.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/centralisation/router.dart';
import 'package:myecl/cinema/router.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:collection/collection.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/home/router.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/tombola/router.dart';
import 'package:myecl/vote/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final modulesProvider =
    StateNotifierProvider<ModulesNotifier, List<Module>>((ref) {
  final myModulesRoot =
      ref.watch(allMyModuleRootList).map((root) => '/$root').toList();

  ModulesNotifier modulesNotifier = ModulesNotifier();
  modulesNotifier.loadModules(myModulesRoot);
  return modulesNotifier;
});

class ModulesNotifier extends StateNotifier<List<Module>> {
  String dbModuleKey = "modules";
  String dbAllModulesKey = "allModules";
  final eq = const DeepCollectionEquality.unordered();
  List<Module> allModules = [
    HomeRouter.module,
    AmapRouter.module,
    AdvertRouter.module,
    BookingRouter.module,
    CinemaRouter.module,
    CentralisationRouter.module,
    EventRouter.module,
    LoanRouter.module,
    RaffleRouter.module,
    VoteRouter.module,
  ];
  ModulesNotifier() : super([]);

  void saveModules() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(dbModuleKey);
      prefs.setStringList(
          dbModuleKey, state.map((e) => e.root.toString()).toList());
    });
  }

  void saveAllModules() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(dbAllModulesKey);
      prefs.setStringList(
          dbAllModulesKey, allModules.map((e) => e.root.toString()).toList());
    });
  }

  Future loadModules(List<String> roots) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> storageModulesName = prefs.getStringList(dbModuleKey) ?? [];
    List<String> allStorageModulesName =
        prefs.getStringList(dbAllModulesKey) ?? [];
    final allModulesName = allModules.map((e) => e.root.toString()).toList();
    if (storageModulesName.isEmpty) {
      storageModulesName = allModulesName;
      saveModules();
    }
    if (allStorageModulesName.isEmpty ||
        !eq.equals(allStorageModulesName, allModulesName)) {
      allStorageModulesName = allModulesName;
      storageModulesName = allModulesName;
      saveAllModules();
      saveModules();
    } else {
      allModules.sort((a, b) => allStorageModulesName
          .indexOf(a.root.toString())
          .compareTo(allStorageModulesName.indexOf(b.root.toString())));
      storageModulesName.sort((a, b) => allStorageModulesName
          .indexOf(a)
          .compareTo(allStorageModulesName.indexOf(b)));
    }
    List<Module> modules = [];
    List<Module> toDelete = [];
    for (String name in storageModulesName) {
      if (allModulesName.contains(name)) {
        Module module = allModules[allStorageModulesName.indexOf(name)];
        if (roots.contains(module.root)) {
          modules.add(module);
        } else {
          toDelete.add(module);
        }
      }
    }
    for (Module module in toDelete) {
      allModules.remove(module);
    }
    state = modules;
  }

  void sortModules() {
    final allModulesName = allModules.map((e) => e.root.toString()).toList();
    final sorted = state.sublist(0)
      ..sort((a, b) => allModulesName
          .indexOf(a.root.toString())
          .compareTo(allModulesName.indexOf(b.root.toString())));
    state = sorted;
    saveModules();
  }

  void reorderModules(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    allModules.insert(newIndex, allModules.removeAt(oldIndex));
    final moduesIds = state.map((e) => e.root.toString()).toList();
    state =
        allModules.where((e) => moduesIds.contains(e.root.toString())).toList();
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
