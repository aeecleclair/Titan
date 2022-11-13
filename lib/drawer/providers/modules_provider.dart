import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/event/providers/is_admin.dart';

class ModuleListNotifier extends StateNotifier<List<Module>> {
  ModuleListNotifier([List<Module>? listModule]) : super(listModule ?? []);

  void select(int i) {
    List<Module> r = state.sublist(0);

    for (int j = 0; j < r.length; j++) {
      if (i == j) {
        r[i].selected = true;
      } else {
        r[j].selected = false;
      }
    }

    state = r;
  }
}

final listModuleProvider =
    StateNotifierProvider<ModuleListNotifier, List<Module>>((ref) {
  final eventAdmin = ref.watch(isEventAdmin);
  return ModuleListNotifier([
    Module(
        name: "Accueil",
        icon: HeroIcons.home,
        page: ModuleType.home,
        selected: true),
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
    if (eventAdmin)
      Module(
          name: "Évenements",
          icon: HeroIcons.calendar,
          page: ModuleType.event,
          selected: false),
    Module(
        name: "Cinéma",
        icon: HeroIcons.ticket,
        page: ModuleType.cinema,
        selected: false),
  ]);
});
