import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseTokenProvider = Provider<Future<String>>((ref) {
  return FirebaseMessaging.instance
      .getToken(vapidKey: "")
      .then((value) => value.toString());
});
