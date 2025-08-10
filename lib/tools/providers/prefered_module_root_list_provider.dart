import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferedModuleRootListNotifier extends StateNotifier<List<String>> {
  static const preferedModuleRootListKey = 'prefered_modules';

  PreferedModuleRootListNotifier() : super([]) {
    loadPreferedModulesRootList();
  }

  Future<void> loadPreferedModulesRootList() async {
    final prefs = await SharedPreferences.getInstance();
    final preferedModuleRootList = prefs.getString(preferedModuleRootListKey);
    if (preferedModuleRootList != null && preferedModuleRootList.isNotEmpty) {
      state = preferedModuleRootList.split(',');
    } else {
      state = [];
    }
  }

  Future<void> addPreferedModulesRoot(String preferedModuleRoot) async {
    final prefs = await SharedPreferences.getInstance();
    final currentListStr = prefs.getString(preferedModuleRootListKey);
    final currentList = currentListStr != null && currentListStr.isNotEmpty
        ? currentListStr.split(',')
        : <String>[];

    if (currentList.length >= 2) return;
    if (!currentList.contains(preferedModuleRoot)) {
      final updatedList = [...currentList, preferedModuleRoot];
      prefs.setString(preferedModuleRootListKey, updatedList.join(','));
      state = updatedList;
    }
  }

  Future<void> removePreferedModulesRoot(String preferedModuleRoot) async {
    final prefs = await SharedPreferences.getInstance();
    final currentListStr = prefs.getString(preferedModuleRootListKey);
    final currentList = currentListStr != null && currentListStr.isNotEmpty
        ? currentListStr.split(',')
        : <String>[];

    if (currentList.contains(preferedModuleRoot)) {
      final updatedList = currentList
          .where((item) => item != preferedModuleRoot)
          .toList();
      prefs.setString(preferedModuleRootListKey, updatedList.join(','));
      state = updatedList;
    }
  }
}

final preferedModuleListRootProvider =
    StateNotifierProvider<PreferedModuleRootListNotifier, List<String>>(
      (ref) => PreferedModuleRootListNotifier(),
    );
