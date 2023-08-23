import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/ui/router.dart';
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
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/vote/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final modulesProvider =
    StateNotifierProvider<ModulesNotifier, List<Module>>((ref) {
  final me = ref.watch(userProvider);
  final isAEMember = me.groups
      .map((e) => e.id)
      .contains("39691052-2ae5-4e12-99d0-7a9f5f2b0136");
  ModulesNotifier modulesNotifier = ModulesNotifier();
  modulesNotifier.loadModules([VoteRouter.root], [isAEMember]);
  return modulesNotifier;
});

class ModulesNotifier extends StateNotifier<List<Module>> {
  String dbModule = "modules";
  String dbAllModules = "allModules";
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
      prefs.remove(dbModule);
      prefs.setStringList(
          dbModule, state.map((e) => e.root.toString()).toList());
    });
  }

  void saveAllModules() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(dbAllModules);
      prefs.setStringList(
          dbAllModules, allModules.map((e) => e.root.toString()).toList());
    });
  }

  Future loadModules(List<String> roots, List<bool> canSee) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> modulesName = prefs.getStringList(dbModule) ?? [];
    List<String> allModulesName = prefs.getStringList(dbAllModules) ?? [];
    final allmodulesName = allModules.map((e) => e.root.toString()).toList();
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
          .indexOf(a.root.toString())
          .compareTo(allModulesName.indexOf(b.root.toString())));
      modulesName.sort((a, b) =>
          allModulesName.indexOf(a).compareTo(allModulesName.indexOf(b)));
    }
    List<Module> modules = [];
    List<Module> toDelete = [];
    for (String name in modulesName) {
      if (allmodulesName.contains(name)) {
        Module module = allModules[allModulesName.indexOf(name)];
        if (roots.contains(module.root)) {
          if (canSee[roots.indexOf(module.root)]) {
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
    final allmodulesName = allModules.map((e) => e.root.toString()).toList();
    final sorted = state.sublist(0)
      ..sort((a, b) => allmodulesName
          .indexOf(a.root.toString())
          .compareTo(allmodulesName.indexOf(b.root.toString())));
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
