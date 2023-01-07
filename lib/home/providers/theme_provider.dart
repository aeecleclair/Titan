import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IsDarkTheme extends StateNotifier<bool> {
  IsDarkTheme() : super(false);

  void toggle() {
    state = !state;
  }

  void loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isDark') ?? false;
  }

  void saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', state);
  }
}

final isDarkThemeProvider = StateNotifierProvider<IsDarkTheme, bool>((ref) {
  final isDarkTheme = IsDarkTheme();
  isDarkTheme.loadFromPrefs();
  return isDarkTheme;
});


final themeModeProvider = Provider<ThemeMode>((ref) {
  final isDark = ref.watch(isDarkThemeProvider);
  return isDark ? ThemeMode.dark : ThemeMode.light;
});