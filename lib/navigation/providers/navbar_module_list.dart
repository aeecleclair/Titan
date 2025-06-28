import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/settings/providers/module_list_provider.dart';

class ModuleListNotifier extends StateNotifier<List<Module>> {
  final int maxNumberOfModules = 3;
  ModuleListNotifier(List<Module> modules)
    : listModule = List.from(modules),
      super(modules.take(3).toList());

  final List<Module> listModule;

  void pushModule(Module module) {
    final existingIndex = listModule.indexWhere((m) => m.root == module.root);

    if (existingIndex == -1) {
      return;
    }

    if (existingIndex < maxNumberOfModules) {
      return;
    }

    listModule.removeAt(existingIndex);
    listModule.insert(0, module);
    state = listModule.take(maxNumberOfModules).toList();
  }
}

final navbarListModuleProvider =
    StateNotifierProvider<ModuleListNotifier, List<Module>>((ref) {
      final modules = ref.watch(modulesProvider);
      return ModuleListNotifier(modules);
    });
