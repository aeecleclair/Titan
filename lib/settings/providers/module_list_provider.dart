import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/advert/router.dart';
import 'package:titan/admin/providers/all_my_module_roots_list_provider.dart';
import 'package:titan/amap/router.dart';
import 'package:titan/booking/router.dart';
import 'package:titan/centralisation/router.dart';
import 'package:titan/cinema/router.dart';
import 'package:titan/event/router.dart';
import 'package:titan/loan/router.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:collection/collection.dart';
import 'package:titan/home/router.dart';
import 'package:titan/paiement/router.dart';
import 'package:titan/ph/router.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/purchases/router.dart';
import 'package:titan/raffle/router.dart';
import 'package:titan/recommendation/router.dart';
import 'package:titan/seed-library/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:titan/settings/router.dart';
import 'package:titan/vote/router.dart';

final modulesProvider = StateNotifierProvider<ModulesNotifier, List<Module>>((
  ref,
) {
  final myModulesRoot = ref
      .watch(allMyModuleRootList)
      .map((root) => '/$root')
      .toList();

  final isAdmin = ref.watch(isAdminProvider);

  ModulesNotifier modulesNotifier = ModulesNotifier(isAdmin: isAdmin);
  modulesNotifier.loadModules(myModulesRoot);
  return modulesNotifier;
});

class ModulesNotifier extends StateNotifier<List<Module>> {
  String dbModule = "modules";
  String dbAllModules = "allModules";
  final bool isAdmin;
  final eq = const DeepCollectionEquality.unordered();
  List<Module> allModules = [
    HomeRouter.module,
    AdvertRouter.module,
    AmapRouter.module,
    BookingRouter.module,
    CentralisationRouter.module,
    CinemaRouter.module,
    EventRouter.module,
    LoanRouter.module,
    PaymentRouter.module,
    PhonebookRouter.module,
    PhRouter.module,
    PurchasesRouter.module,
    RaffleRouter.module,
    RecommendationRouter.module,
    VoteRouter.module,
    SeedLibraryRouter.module,
  ];
  ModulesNotifier({required this.isAdmin}) : super([]);

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
    allModules.addAll([SettingsRouter.module, if (isAdmin) AdminRouter.module]);
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
