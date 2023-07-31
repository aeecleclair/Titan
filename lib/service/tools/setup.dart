import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/service/local_notification_service.dart';
import 'package:myecl/service/providers/firebase_token_provider.dart';
import 'package:myecl/service/providers/messages_provider.dart';
import 'package:myecl/service/providers/topic_provider.dart';
import 'package:myecl/tools/logs/log.dart';
import 'package:myecl/tools/repository/repository.dart';

void setUpNotification(WidgetRef ref) {
  final LocalNotificationService localNotificationService =
      LocalNotificationService();
  localNotificationService.init();

  final messageNotifier = ref.watch(messagesProvider.notifier);
  final firebaseToken = ref.watch(firebaseTokenProvider);
  final topicsNotifier = ref.watch(topicsProvider.notifier);
  final logger = Repository.logger;

  FirebaseMessaging.instance.requestPermission().then((value) {
    if (value.authorizationStatus == AuthorizationStatus.authorized) {
      firebaseToken.then((value) {
        messageNotifier.setFirebaseToken(value);
        messageNotifier.registerDevice();
        logger.writeLog(Log(
            message: "Firebase messaging token registered",
            level: LogLevel.info));
        topicsNotifier.getTopics();
      });
    }
  });

  void handleMessages() async {
    final messages = await messageNotifier.getMessages();
    messages.when(
      data: (messageList) {
        for (final message in messageList) {
          if (message.isVisible) {
            final action = message.action;
            if (action == null) {
              localNotificationService.showNotification(
                message.context,
                message.title,
                message.content,
              );
            } else {
              localNotificationService.showNotificationWithPayload(
                message.context,
                message.title,
                message.content,
                action.toJson().toString(),
              );
            }
          }
        }
      },
      loading: () {},
      error: (error, stack) {
        localNotificationService.showNotification(
          'error',
          'Erreur',
          'Impossible de récupérer les notifications',
        );
      },
    );
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    handleMessages();
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    handleMessages();
  });
}
