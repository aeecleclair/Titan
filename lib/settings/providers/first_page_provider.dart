import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPageNotifier extends StateNotifier<ModuleType> {
  final eq = const DeepCollectionEquality.unordered();
  FirstPageNotifier() : super(ModuleType.amap);

  Future loadFirstPage() async {
    String dbModule = "modules";
    String dbAllModules = "allModules";
    final prefs = await SharedPreferences.getInstance();
    List<String> modulesName = prefs.getStringList(dbModule) ?? [];
    List<String> allModulesName = prefs.getStringList(dbAllModules) ?? [];
    final Map<String, ModuleType> dict = {
      for (ModuleType x in ModuleType.values) x.toString(): x
    };
    if (allModulesName.isEmpty) {
      modulesName.sort((a, b) =>
          allModulesName.indexOf(a).compareTo(allModulesName.indexOf(b)));
    }
    state = dict[modulesName[0]] ?? ModuleType.amap;
  }
}

final firstPageProvider =
    StateNotifierProvider<FirstPageNotifier, ModuleType>((ref) {
  FirstPageNotifier modulesNotifier = FirstPageNotifier();
  modulesNotifier.loadFirstPage();
  return modulesNotifier;
});
