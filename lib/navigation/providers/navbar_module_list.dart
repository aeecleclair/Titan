import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/feed/router.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/settings/providers/module_list_provider.dart';
import 'package:titan/tools/providers/prefered_module_root_list_provider.dart';

class ModuleListNotifier extends Notifier<List<Module>> {
  final int maxNumberOfModules = 2;

  @override
  List<Module> build() {
    final allModules = ref.watch(modulesProvider);
    final preferedRoots = ref.watch(preferedModuleListRootProvider);

    return _initState(allModules, preferedRoots, maxNumberOfModules);
  }

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
    NotifierProvider<ModuleListNotifier, List<Module>>(ModuleListNotifier.new);
