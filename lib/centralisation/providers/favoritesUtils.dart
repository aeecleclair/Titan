import 'package:shared_preferences/shared_preferences.dart';
import 'package:myecl/centralisation/class/module.dart';
import 'dart:convert';

Future<void> saveFavoritesToSharedPreferences(List<Module> favoritesList) async {
  final prefs = await SharedPreferences.getInstance();
  final favoritesJson = favoritesList.map((module) => module.toJson()).toList();
  await prefs.setString('favorites', json.encode(favoritesJson));
}