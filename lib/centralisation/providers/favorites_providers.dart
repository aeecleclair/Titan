import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/class/module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myecl/centralisation/tools/functions.dart';
import 'dart:convert';
import 'dart:async';

class FavoritesNotifier extends StateNotifier<List<Module>> {
  FavoritesNotifier() : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString('favorites');

    if (favoritesJson != null) {
      final favoritesList = json.decode(favoritesJson) as List<dynamic>;
      final favorites = favoritesList
          .map((moduleJson) => Module.fromJson(moduleJson))
          .toList();
      state = favorites;
    }
  }

  void toggleFavorite(Module module) {
    if (state.contains(module)) {
      state = state.where((m) => m != module).toList();
    } else {
      state = [...state, module];
    }
    saveFavoritesToSharedPreferences(
        state);
  }
}


final favoritesProvider =
StateNotifierProvider<FavoritesNotifier, List<Module>>(
        (ref) => FavoritesNotifier());
