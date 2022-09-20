import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TitanVersionNotfier extends StateNotifier<String> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String _key = 'titan_version';
  TitanVersionNotfier() : super('1.0.0');

  Future<String> loadVersionFromStorage() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_key) ?? '1.0.0';
  }

  Future<bool> saveVersionToStorage(String version) async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.setString(_key, version).then((bool success) {
        return success;
      });
  }
}

final titanVersionProvider =
    StateNotifierProvider<TitanVersionNotfier, String>((ref) {
  final notifier = TitanVersionNotfier();
  notifier.loadVersionFromStorage();
  return notifier;
});
