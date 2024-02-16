import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/router.dart';
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
import 'package:myecl/raffle/router.dart';
import 'package:myecl/vote/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final modulesProvider =
    StateNotifierProvider<ModulesNotifier, List<Module>>((ref) {
  final userRoots =
      ref.watch(allMyModuleRootList).map((root) => '/$root').toList();

  ModulesNotifier modulesNotifier = ModulesNotifier();
  modulesNotifier.loadModules(userRoots);
  return modulesNotifier;
});

class ModulesNotifier extends StateNotifier<List<Module>> {
  String dbSelectedModules = "modules";
  String dbAllModules = "allModules";
  final eq = const DeepCollectionEquality.unordered();
  List<Module> allModules = [
    HomeRouter.module,
    AdvertRouter.module,
    VoteRouter.module,
    CentralisationRouter.module,
    AmapRouter.module,
    CinemaRouter.module,
    BookingRouter.module,
    LoanRouter.module,
    EventRouter.module,
    RaffleRouter.module,
  ];
  ModulesNotifier() : super([]);

  void saveModules() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(dbSelectedModules);
      prefs.setStringList(
          dbSelectedModules, state.map((e) => e.root.toString()).toList());
    });
  }

  void saveAllModules() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(dbAllModules);
      prefs.setStringList(
          dbAllModules, allModules.map((e) => e.root.toString()).toList());
    });
  }

  Future loadModules(List<String> userRoots) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> selectedModulesRoot =
        prefs.getStringList(dbSelectedModules) ?? [];
    List<String> allSavedModulesRoot = prefs.getStringList(dbAllModules) ?? [];
    final allModulesRoot = allModules.map((e) => e.root.toString()).toList();
    if (selectedModulesRoot.isEmpty) {
      selectedModulesRoot = allModulesRoot;
      saveModules();
    }
    if (allSavedModulesRoot.isEmpty ||
        !eq.equals(allSavedModulesRoot, allModulesRoot)) {
      allSavedModulesRoot = allModulesRoot;
      selectedModulesRoot = allModulesRoot;
      saveAllModules();
      saveModules();
    } else {
      allModules.sort((a, b) => allSavedModulesRoot
          .indexOf(a.root.toString())
          .compareTo(allSavedModulesRoot.indexOf(b.root.toString())));
      selectedModulesRoot.sort((a, b) => allSavedModulesRoot
          .indexOf(a)
          .compareTo(allSavedModulesRoot.indexOf(b)));
    }
    List<Module> selectedModules = [];
    List<Module> toDelete = [];
    for (String root in selectedModulesRoot) {
      if (allModulesRoot.contains(root)) {
        Module module = allModules[allSavedModulesRoot.indexOf(root)];
        if (userRoots.contains(module.root)) {
          selectedModules.add(module);
        } else if (!kDebugMode) {
          // Allow debug on modules that don't have a Hyperion Module Visibility root
          toDelete.add(module);
        }
      }
    }
    for (Module module in toDelete) {
      allModules.remove(module);
    }
    state = selectedModules;
  }

  void sortModules() {
    final allModulesRoot = allModules.map((e) => e.root.toString()).toList();
    final sorted = state.sublist(0)
      ..sort((a, b) => allModulesRoot
          .indexOf(a.root.toString())
          .compareTo(allModulesRoot.indexOf(b.root.toString())));
    state = sorted;
    saveModules();
  }

  void reorderModules(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    allModules.insert(newIndex, allModules.removeAt(oldIndex));
    final modulesIds = state.map((e) => e.root.toString()).toList();
    state = allModules
        .where((e) => modulesIds.contains(e.root.toString()))
        .toList();
    saveAllModules();
  }

  void toggleModule(Module module) {
    List<Module> selectedModules = state.sublist(0);
    if (selectedModules.contains(module)) {
      selectedModules.remove(module);
    } else {
      selectedModules.add(module);
    }
    state = selectedModules;
    sortModules();
    saveModules();
  }
}
