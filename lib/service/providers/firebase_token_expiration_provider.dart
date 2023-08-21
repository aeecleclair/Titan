import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseTokenExpirationNotifier extends StateNotifier<DateTime?> {
  final String dbDate = "firebaseTokenExpiration";
  FirebaseTokenExpirationNotifier() : super(null);

  void getSavedDate() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString(dbDate);
    if (savedDate != null) {
      state = DateTime.parse(savedDate);
    } else {
      state = DateTime.fromMicrosecondsSinceEpoch(0);
    }
  }

  void reset() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(dbDate);
    state = null;
  }

  void saveDate(DateTime expiration) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(dbDate, expiration.toString());
    state = expiration;
  }
}

final firebaseTokenExpirationProvider =
    StateNotifierProvider<FirebaseTokenExpirationNotifier, DateTime?>((ref) {
  FirebaseTokenExpirationNotifier firebaseTokenExpirationNotifier =
      FirebaseTokenExpirationNotifier();
  firebaseTokenExpirationNotifier.getSavedDate();
  return firebaseTokenExpirationNotifier;
});
