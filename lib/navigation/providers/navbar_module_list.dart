import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/settings/providers/module_list_provider.dart';
import 'package:titan/tools/providers/prefered_module_root_list_provider.dart';

class ModuleListNotifier extends StateNotifier<List<Module>> {
  final int maxNumberOfModules;
  final List<Module> allModules;

  ModuleListNotifier(
    this.allModules,
    List<String> preferedRoots, {
    this.maxNumberOfModules = 2,
  }) : super(_initState(allModules, preferedRoots, maxNumberOfModules));

  static List<Module> _initState(
    List<Module> allModules,
    List<String> preferedRoots,
    int max,
  ) {
    final preferredModules = allModules
        .where((m) => preferedRoots.contains(m.root))
        .toList();

    final filled = List<Module>.from(preferredModules);
    if (filled.length < max) {
      for (final m in allModules) {
        if (!filled.contains(m)) {
          filled.add(m);
          if (filled.length == max) break;
        }
      }
    }

    return filled.take(max).toList();
  }

  void pushModule(Module module) {
    final updated = List<Module>.from(state);

    final idx = updated.indexWhere((m) => m.root == module.root);
    if (idx != -1) {
      updated.removeAt(idx);
      updated.insert(0, module);
    } else {
      updated.insert(0, module);
      if (updated.length > maxNumberOfModules) {
        updated.removeLast();
      }
    }

    state = updated;
  }
}

final navbarListModuleProvider =
    StateNotifierProvider<ModuleListNotifier, List<Module>>((ref) {
      final modules = ref.watch(modulesProvider);
      final preferedRoots = ref.watch(preferedModuleListRootProvider);
      return ModuleListNotifier(modules, preferedRoots);
    });
