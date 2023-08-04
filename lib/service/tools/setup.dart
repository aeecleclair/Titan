import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/service/local_notification_service.dart';
import 'package:myecl/service/providers/firebase_token_provider.dart';
import 'package:myecl/service/providers/messages_provider.dart';
import 'package:myecl/service/providers/topic_provider.dart';
import 'package:myecl/service/repositories/notification_repository.dart';
import 'package:myecl/tools/logs/log.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

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
              continue;
            }
            if (actionModule == null || actionTable == null) {
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
                json.encode(message.toJson()),
              );
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
  FirebaseMessaging.instance.requestPermission().then((value) async {
    if (value.authorizationStatus == AuthorizationStatus.authorized) {
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
          localNotificationService.showNotificationWithPayload(
            message.context,
            message.title,
            message.content,
            json.encode(message.toJson()),
          );
        }
      }
    }
  });
}