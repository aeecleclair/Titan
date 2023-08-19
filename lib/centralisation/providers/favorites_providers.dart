import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/class/module.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

class FavoritesNotifier extends StateNotifier<List<Module>> {
  final key = 'favorites';
  FavoritesNotifier() : super([]);

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString(key);

    if (favoritesJson != null) {
      final favoritesList = json.decode(favoritesJson) as List<dynamic>;
      final favorites = favoritesList
          .map((moduleJson) => Module.fromJson(moduleJson))
          .toList();
      state = favorites;
    }
  }

  void toggleFavorite(Module module) {
    final modulesName = state.map((module) => module.name).toList();
    if (modulesName.contains(module.name)) {
      state = state.where((m) => m.name != module.name).toList();
    } else {
      state = [...state, module];
    }
    saveFavoritesToSharedPreferences(state);
  }

  Future<void> saveFavoritesToSharedPreferences(
      List<Module> favoritesList) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson =
        favoritesList.map((module) => module.toJson()).toList();
    await prefs.setString(key, json.encode(favoritesJson));
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Module>>((ref) {
  final favoritesNotifier = FavoritesNotifier();
  tokenExpireWrapperAuth(ref, () async {
    favoritesNotifier.loadFavorites();
  });
  return favoritesNotifier;
});
