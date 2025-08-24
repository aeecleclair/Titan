import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:titan/service/class/message.dart' as message_class;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/service/local_notification_service.dart';
import 'package:titan/service/providers/firebase_token_expiration_provider.dart';
import 'package:titan/service/providers/firebase_token_provider.dart';
import 'package:titan/service/providers/messages_provider.dart';
import 'package:titan/service/providers/topic_provider.dart';
import 'package:titan/tools/logs/log.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/user/providers/user_provider.dart';

void setUpNotification(WidgetRef ref) {
  final LocalNotificationService localNotificationService =
      LocalNotificationService();
  localNotificationService.init();

  final user = ref.watch(userProvider);
  final messageNotifier = ref.watch(messagesProvider.notifier);
  final firebaseToken = ref.watch(firebaseTokenProvider);
  final topicsNotifier = ref.watch(topicsProvider.notifier);
  final logger = Repository.logger;

  FirebaseMessaging.instance.requestPermission().then((value) {
    if (value.authorizationStatus == AuthorizationStatus.authorized) {
      final firebaseTokenExpiration = ref.watch(
        firebaseTokenExpirationProvider,
      );
      final firebaseTokenExpirationNotifier = ref.read(
        firebaseTokenExpirationProvider.notifier,
      );
      final now = DateTime.now();
      if (firebaseTokenExpiration.userId != user.id ||
          firebaseTokenExpiration.expiration != null ||
          firebaseTokenExpiration.expiration!.isBefore(now)) {
        firebaseToken.then((value) {
          messageNotifier.setFirebaseToken(value);
          messageNotifier.registerDevice();
          firebaseTokenExpirationNotifier.saveDate(
            user.id,
            now.add(const Duration(days: 30)),
          );
          logger.info("Firebase messaging token registered");
          topicsNotifier.getTopics();
        });
      }
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    message_class.Message messages = message_class.Message.fromJson(
      message.data,
    );
    Repository.logger.writeLog(
      Log(message: "GOT trigger onMessage", level: LogLevel.error),
    );

    message_class.Message me = message_class.Message(
      title: message.notification?.title,
      content: message.notification?.body,
      actionModule: messages.actionModule,
      actionTable: messages.actionTable,
    );
    localNotificationService.showNotification(me);
  });
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await dotenv.load();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();
  await LocalNotificationService().init();
  final LocalNotificationService localNotificationService =
      LocalNotificationService();
  localNotificationService.init();
}
