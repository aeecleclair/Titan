import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/servide/cinema_service.dart';
import 'package:myecl/service/local_notification_service.dart';
import 'package:myecl/service/providers/firebase_token_provider.dart';
import 'package:myecl/service/providers/messages_provider.dart';
import 'package:myecl/service/providers/topic_provider.dart';
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
  final providers = {"cinema": cinemaProviders};

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

  Future<String> handleAction(String actionModule, String actionTable) async {
    final provider = providers[actionModule];
    if (provider == null) {
      return "";
    }
    final information = provider[actionTable];
    if (information == null) {
      return "";
    }
    final path = information.item1;
    final notifier = information.item2;
    ref.read(notifier).refresh();
    return path;
  }

  void handleMessages() async {
    tokenExpireWrapper(ref, () async {
      final messages = await messageNotifier.getMessages();
      messages.maybeWhen(
        data: (messageList) async {
          for (final message in messageList) {
            final title = message.title;
            final content = message.content;
            if (title == null && content == null) {
              continue;
            }
            final actionModule = message.actionModule;
            final actionTable = message.actionTable;
            if (!message.isVisible) {
              if (actionModule != null && actionTable != null) {
                handleAction(actionModule, actionTable);
              }
            }
            if (actionModule == null || actionTable == null) {
              localNotificationService.showNotification(
                message.context,
                message.title ?? "MyECL",
                message.content ?? "",
              );
            } else {
              final path = await handleAction(actionModule, actionTable);
              localNotificationService.showNotificationWithPayload(
                message.context,
                message.title ?? "MyECL",
                message.content ?? "",
                path,
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
