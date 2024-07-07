import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  ThemeNotifier themeNotifier = ThemeNotifier();
  return themeNotifier;
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false);

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
      state = pref.getBool("isDarkMode") ?? false;
    });
  }

  void toggleTheme() {
    state = !state;
    saveTheme();
  }
}

/*
void loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isDark') ?? false;
  }

  void saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', state);
  }
*/