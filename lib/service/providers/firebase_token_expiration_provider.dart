import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/service/class/firebase_toke_expiration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseTokenExpirationNotifier
    extends StateNotifier<FirebaseTokenExpiration> {
  final String dbDate = "firebaseTokenExpiration";
  FirebaseTokenExpirationNotifier() : super(FirebaseTokenExpiration.empty());

  void getSavedDate() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString(dbDate);
    if (savedDate != null) {
      state = FirebaseTokenExpiration.fromJson(json.decode(savedDate));
    } else {
      state = FirebaseTokenExpiration.empty().copyWith(
        expiration: DateTime.now(),
      );
    }
  }

  void reset() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(dbDate);
    state = FirebaseTokenExpiration.empty();
  }

  void saveDate(String userId, DateTime expiration) async {
    final newFirebaseTokenExpiration = FirebaseTokenExpiration(
      userId,
      expiration,
    );
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(dbDate, json.encode(newFirebaseTokenExpiration.toJson()));
    state = newFirebaseTokenExpiration;
  }
}

final firebaseTokenExpirationProvider =
    StateNotifierProvider<
      FirebaseTokenExpirationNotifier,
      FirebaseTokenExpiration
    >((ref) {
      FirebaseTokenExpirationNotifier firebaseTokenExpirationNotifier =
          FirebaseTokenExpirationNotifier();
      firebaseTokenExpirationNotifier.getSavedDate();
      return firebaseTokenExpirationNotifier;
    });
