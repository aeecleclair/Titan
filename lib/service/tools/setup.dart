import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/service/local_notification_service.dart';
import 'package:myecl/service/providers/firebase_token_expiration_provider.dart';
import 'package:myecl/service/providers/firebase_token_provider.dart';
import 'package:myecl/service/providers/messages_provider.dart';
import 'package:myecl/service/providers/topic_provider.dart';
import 'package:myecl/service/repositories/notification_repository.dart';
import 'package:myecl/tools/logs/log.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_provider.dart';

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
      final firebaseTokenExpiration =
          ref.watch(firebaseTokenExpirationProvider);
      final firebaseTokenExpirationNotifier =
          ref.read(firebaseTokenExpirationProvider.notifier);
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
          logger.info(
            "Firebase messaging token registered",
          );
          topicsNotifier.getTopics();
        });
      }
    }
  });

  void handleMessages() async {
    tokenExpireWrapper(ref, () async {
      final messages = await messageNotifier.getMessages();
      messages.maybeWhen(
        data: (messageList) async {
          for (final message in messageList) {
            final actionModule = message.actionModule;
            final actionTable = message.actionTable;
            if (!message.isVisible &&
                actionModule != null &&
                actionTable != null) {
              localNotificationService.handleAction(actionModule, actionTable);
            } else {
              localNotificationService.showNotification(message);
            }
          }
        },
        orElse: () {},
      );
    });
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    handleMessages();
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    handleMessages();
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
  final firebaseToken = await FirebaseMessaging.instance
      .getToken(vapidKey: "")
      .then((value) => value.toString());
  NotificationRepository notificationRepository = NotificationRepository();
  final messages = await notificationRepository.getMessages(firebaseToken);
  for (final message in messages) {
    if (message.isVisible) {
      localNotificationService.showNotification(message);
    }
  }
}
