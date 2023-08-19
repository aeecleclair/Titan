import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/centralisation/class/module.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

class FavoritesNameNotifier extends StateNotifier<List<String>> {
  final key = 'favorites';
  FavoritesNameNotifier() : super([]);

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(key);

    if (favoritesJson != null) {
     state = favoritesJson;
    }
  }

  void toggleFavorite(String name) {
    if (state.contains(name)) {
      state = state.where((m) => m != name).toList();
    } else {
      state = [...state, name];
    }
    saveFavoritesToSharedPreferences(state);
  }

  Future<void> saveFavoritesToSharedPreferences(
      List<String> favoritesList) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, state);
  }
}

final favoritesNameProvider =
    StateNotifierProvider<FavoritesNameNotifier, List<String>>((ref) {
  final favoritesNameNotifier = FavoritesNameNotifier();
  tokenExpireWrapperAuth(ref, () async {
    favoritesNameNotifier.loadFavorites();
  });
  return favoritesNameNotifier;
});
