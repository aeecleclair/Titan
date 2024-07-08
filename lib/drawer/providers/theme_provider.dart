import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  ThemeNotifier themeNotifier = ThemeNotifier();
  themeNotifier.loadTheme();
  return themeNotifier;
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier()
      : super(
          SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark,
        ); // System-based default theme

  void saveTheme() {
    SharedPreferences.getInstance().then((pref) {
      pref.setBool(
        'isDarkMode',
        state,
      );
    });
  }

  void loadTheme() {
    SharedPreferences.getInstance().then((pref) {
      state = pref.getBool('isDarkMode') ??
          (SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark);
    });
  }

  void toggleTheme() {
    state = !state;
    saveTheme();
  }
}
