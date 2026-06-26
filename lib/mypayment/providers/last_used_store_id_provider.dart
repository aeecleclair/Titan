import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class LastUsedStoreIdNotifier extends Notifier<String> {
  final key = 'last_used_store';

  @override
  String build() {
    return '';
  }

  Future<void> loadLastUsedStoreId() async {
    final prefs = await SharedPreferences.getInstance();
    final savedStoreId = prefs.getString(key);

    if (savedStoreId != null) {
      state = savedStoreId;
    }
  }

  Future<void> saveLastUsedStoreIdToSharedPreferences(String storeId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, storeId);
  }
}

final lastUsedStoreIdProvider =
    NotifierProvider<LastUsedStoreIdNotifier, String>(
      LastUsedStoreIdNotifier.new,
    );
