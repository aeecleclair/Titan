import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  void reorderFavorites(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final copy = state.sublist(0);
    final String item = copy.removeAt(oldIndex);
    copy.insert(newIndex, item);
    state = copy;
    saveFavoritesToSharedPreferences(copy);
  }

  Future<void> saveFavoritesToSharedPreferences(
    List<String> favoritesList,
  ) async {
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
