import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/router.dart';
import 'package:myecl/admin/providers/all_my_module_roots_list_provider.dart';
import 'package:myecl/amap/router.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/centralisation/router.dart';
import 'package:myecl/centralassos/router.dart';
import 'package:myecl/cinema/router.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:collection/collection.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/home/router.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/purchases/router.dart';
import 'package:myecl/raffle/router.dart';
import 'package:myecl/recommendation/router.dart';
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
  String dbModule = "modules";
  String dbAllModules = "allModules";
  final eq = const DeepCollectionEquality.unordered();
  List<Module> allModules = [
    HomeRouter.module,
    CentralisationRouter.module,
    CentralassociationRouter.module,
    PhRouter.module,
    CinemaRouter.module,
    AmapRouter.module,
    BookingRouter.module,
    LoanRouter.module,
    PhonebookRouter.module,
    PurchasesRouter.module,
    RecommendationRouter.module,
    AdvertRouter.module,
    EventRouter.module,
    VoteRouter.module,
    RaffleRouter.module,
  ];
  ModulesNotifier() : super([]);

  void saveModules() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(dbModule);
      prefs.setStringList(
        dbModule,
        state.map((e) => e.root.toString()).toList(),
      );
    });
  }

  void saveAllModules() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(dbAllModules);
      prefs.setStringList(
        dbAllModules,
        allModules.map((e) => e.root.toString()).toList(),
      );
    });
  }

  Future loadModules(List<String> roots) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> modulesName = prefs.getStringList(dbModule) ?? [];
    List<String> allSavedModulesName = prefs.getStringList(dbAllModules) ?? [];
    final allModulesName = allModules.map((e) => e.root.toString()).toList();
    if (modulesName.isEmpty) {
      modulesName = allModulesName;
      saveModules();
    }
    if (allSavedModulesName.isEmpty ||
        !eq.equals(allSavedModulesName, allModulesName)) {
      allSavedModulesName = allModulesName;
      modulesName = allModulesName;
      saveAllModules();
      saveModules();
    } else {
      allModules.sort(
        (a, b) => allSavedModulesName
            .indexOf(a.root.toString())
            .compareTo(allSavedModulesName.indexOf(b.root.toString())),
      );
      modulesName.sort(
        (a, b) => allSavedModulesName
            .indexOf(a)
            .compareTo(allSavedModulesName.indexOf(b)),
      );
    }
    List<Module> modules = [];
    List<Module> toDelete = [];
    for (String name in modulesName) {
      if (allModulesName.contains(name)) {
        Module module = allModules[allSavedModulesName.indexOf(name)];
        if (roots.contains(module.root)) {
          modules.add(module);
        } else if (!kDebugMode) {
          toDelete.add(module);
        }
      }
    }
    for (Module module in toDelete) {
      allModules.remove(module);
    }
    state = allModules;
  }

  void sortModules() {
    final allModulesName = allModules.map((e) => e.root.toString()).toList();
    final sorted = state.sublist(0)
      ..sort(
        (a, b) => allModulesName
            .indexOf(a.root.toString())
            .compareTo(allModulesName.indexOf(b.root.toString())),
      );
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
