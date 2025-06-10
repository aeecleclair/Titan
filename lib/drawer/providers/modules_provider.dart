import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/drawer/class/module.dart';
import 'package:titan/settings/providers/module_list_provider.dart';

class ModuleListNotifier extends StateNotifier<List<Module>> {
  ModuleListNotifier(super.listModule);

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
      final modules = ref.watch(modulesProvider);
      return ModuleListNotifier(modules);
    });
