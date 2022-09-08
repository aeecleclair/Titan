import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/drawer/providers/page_provider.dart';

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
  return ModuleListNotifier([
    Module(name: "Accueil", icon: HeroIcons.home, page: ModuleType.home, selected: true),
    Module(
        name: "Réservation", icon: HeroIcons.table, page: ModuleType.booking, selected: false),
    Module(name: "Prêt", icon: HeroIcons.library, page: ModuleType.loan, selected: false),
    Module(name: "Amap", icon: HeroIcons.shoppingCart, page: ModuleType.amap, selected: false),
    Module(name: "Évenements", icon: HeroIcons.calendar, page: ModuleType.event, selected: false),
  ]);
});
