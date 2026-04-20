import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/feed/router.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/settings/providers/module_list_provider.dart';
import 'package:titan/tools/providers/prefered_module_root_list_provider.dart';

class ModuleListNotifier extends StateNotifier<List<Module>> {
  final int maxNumberOfModules;
  List<Module> allModules;
  List<String> preferedRoots;

  ModuleListNotifier(
    this.allModules,
    this.preferedRoots, {
    this.maxNumberOfModules = 2,
  }) : super(_initState(allModules, preferedRoots, maxNumberOfModules));

  static List<Module> _initState(
    List<Module> allModules,
    List<String> preferedRoots,
    int max,
  ) {
    final availableModules = allModules
        .where((m) => m.root != FeedRouter.root)
        .toList();

    final preferredModules = availableModules
        .where((m) => preferedRoots.contains(m.root))
        .toList();

    final filled = List<Module>.from(preferredModules);
    if (filled.length < max) {
      for (final m in availableModules) {
        if (!filled.contains(m)) {
          filled.add(m);
          if (filled.length == max) break;
        }
      }
    }

    return filled.take(max).toList();
  }

  void sync(List<Module> modules, List<String> newPreferedRoots) {
    if (modules.isEmpty) return;
    allModules = modules;
    preferedRoots = newPreferedRoots;

    final availableModules = modules
        .where((m) => m.root != FeedRouter.root)
        .toList();
    final availableRoots = availableModules.map((m) => m.root).toSet();

    final next = <Module>[];

    for (final m in state) {
      final match = availableModules
          .where((am) => am.root == m.root)
          .firstOrNull;
      if (match != null && !next.any((nm) => nm.root == match.root)) {
        next.add(match);
      }
    }

    for (final pref in newPreferedRoots) {
      if (next.any((nm) => nm.root == pref)) continue;
      if (!availableRoots.contains(pref)) continue;
      final match = availableModules.firstWhere((m) => m.root == pref);
      next.add(match);
    }

    for (final m in availableModules) {
      if (next.length >= maxNumberOfModules) break;
      if (!next.any((nm) => nm.root == m.root)) {
        next.add(m);
      }
    }

    state = next.take(maxNumberOfModules).toList();
  }

  void pushModule(Module module) {
    // Ne pas ajouter le module feed car il est déjà fixe en première position de la navbar
    if (module.root == FeedRouter.root) return;

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
      final modules = ref.read(modulesProvider);
      final preferedRoots = ref.read(preferedModuleListRootProvider);
      final notifier = ModuleListNotifier(modules, preferedRoots);

      ref.listen<List<Module>>(modulesProvider, (_, next) {
        notifier.sync(next, ref.read(preferedModuleListRootProvider));
      });
      ref.listen<List<String>>(preferedModuleListRootProvider, (_, next) {
        notifier.sync(ref.read(modulesProvider), next);
      });

      return notifier;
    });
