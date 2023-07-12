import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:myecl/service/class/message.dart';
import 'package:myecl/service/local_notification_service.dart';
import 'package:myecl/service/repositories/notification_repository.dart';

class PushNotificationService {
  static void initialize() {
    FirebaseMessaging.instance.requestPermission();
    final LocalNotificationService localNotificationService = LocalNotificationService();
    localNotificationService.init();
    final NotificationRepository notificationRepository = NotificationRepository();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("token : ${await getToken()}");
      for (Message m in await notificationRepository.getMessages((await getToken())!)) {
        localNotificationService.showNotification(m.context, m.title, m.content);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message);
      if (message.notification != null) {
        print("onMessageOpenedApp: ${message.notification!.body}");
      }
    });
  }

  static Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken(vapidKey: "");
  }

}
