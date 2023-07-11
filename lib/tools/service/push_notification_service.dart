import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static void initialize() {
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("Message: ${message.notification!.body}");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("Message: ${message.notification!.body}");
      }
    });
  }

  static Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken(vapidKey: "");
  }

}
