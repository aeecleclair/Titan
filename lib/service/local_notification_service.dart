import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myecl/service/class/message.dart' as message_class;
import 'package:myecl/service/provider_list.dart';
import 'package:myecl/tools/functions.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService() {
    onNotificationClick.listen(onNotificationClickListener);
  }

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<message_class.Message> onNotificationClick =
      BehaviorSubject();

  Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Europe/Paris"));
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _localNotificationService.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveBackgroundNotificationResponse);
  }

  NotificationDetails getNotificationDetails() {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("fr.myecl.titan", "TitanNotification",
            channelDescription: "Notifications channel for Titan",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    return NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
  }

  Future showNotification(message_class.Message message) async {
    final notificationDetails = getNotificationDetails();
    if (message.deliveryDateTime == null) {
      _localNotificationService.show(generateIntFromString(message.context),
          message.title, message.content, notificationDetails,
          payload: json.encode(message.toJson()));
      return;
    }
    tz.TZDateTime dateToDisplay = tz.TZDateTime.from(message.deliveryDateTime!,
        tz.local); // TODO: The -2h is a fix that need to be deleted once UTC dates will be used
    final now = tz.TZDateTime.now(tz.local);
    if (dateToDisplay.isAfter(now)) {
      _localNotificationService.zonedSchedule(
          generateIntFromString(message.context),
          message.title,
          message.content,
          dateToDisplay.subtract(const Duration(hours: 2)),
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: json.encode(message.toJson()));
    } else {
      _localNotificationService.show(generateIntFromString(message.context),
          message.title, message.content, notificationDetails,
          payload: json.encode(message.toJson()));
    }
  }

  Future<void> showPeriodicNotification(String id, String? title, String? body,
      String? payload, RepeatInterval repeatInterval) async {
    await _localNotificationService.periodicallyShow(generateIntFromString(id),
        title, body, repeatInterval, getNotificationDetails(),
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  Future<void> showNotificationWithImage(String id, String? title, String? body,
      String payload, String imageUrl, String largeIcon) async {
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(imageUrl),
            largeIcon: FilePathAndroidBitmap(largeIcon),
            hideExpandedLargeIcon: true,
            contentTitle: title,
            htmlFormatContentTitle: true,
            summaryText: body,
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails("fr.myecl.titan", "TitanNotification",
            channelDescription: "Notifications channel for Titan",
            importance: Importance.max,
            priority: Priority.max,
            styleInformation: bigPictureStyleInformation,
            playSound: true);
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _localNotificationService.show(
        generateIntFromString(id), title, body, platformChannelSpecifics,
        payload: payload);
  }

  Future<void> groupNotifications() async {
    AndroidNotificationChannelGroup channelGroup =
        const AndroidNotificationChannelGroup(
            'com.my.app.alert1', 'mychannel1');
    await _localNotificationService
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannelGroup(channelGroup);
    List<ActiveNotification>? activeNotifications =
        await _localNotificationService
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.getActiveNotifications();

    if (activeNotifications != null && activeNotifications.isNotEmpty) {
      List<String> lines =
          activeNotifications.map((e) => e.title.toString()).toList();
      InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
        lines,
        contentTitle: "${activeNotifications.length - 1} Updates",
        summaryText: "${activeNotifications.length - 1} Updates",
      );
      AndroidNotificationDetails groupNotificationDetails =
          AndroidNotificationDetails(
        channelGroup.id,
        channelGroup.name,
        channelDescription: channelGroup.description,
        styleInformation: inboxStyleInformation,
        setAsGroupSummary: true,
        groupKey: channelGroup.id,
        // onlyAlertOnce: true,
      );
      NotificationDetails groupNotificationDetailsPlatformSpefics =
          NotificationDetails(android: groupNotificationDetails);
      await _localNotificationService.show(
          0, '', '', groupNotificationDetailsPlatformSpefics);
    }
  }

  Future<List<PendingNotificationRequest>> pendingNotificationRequests() async {
    return await _localNotificationService.pendingNotificationRequests();
  }

  Future<PendingNotificationRequest?> getNotificationDetail(String id) async {
    final notificationId = generateIntFromString(id);
    final pendingNotificationRequests =
        await _localNotificationService.pendingNotificationRequests();
    return pendingNotificationRequests
        .firstWhereOrNull((element) => element.id == notificationId);
  }

  Future<void> cancelNotificationById(String id) async {
    await _localNotificationService.cancel(generateIntFromString(id));
  }

  Future<void> cancelAllNotifications() async {
    await _localNotificationService.cancelAll();
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    if (payload == null) {
      return;
    }
    final message = message_class.Message.fromJson(
        jsonDecode(utf8.decode(payload.runes.toList())));
    onNotificationClick.add(message);
  }

  Future<String> handleAction(String actionModule, String actionTable) async {
    final provider = providers[actionModule];
    if (provider == null) {
      return "";
    }
    final information = provider[actionTable];
    if (information == null) {
      return "";
    }
    return information.item1;
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) async {
    if (response.payload == null) {
      return;
    }
    final message = message_class.Message.fromJson(
        jsonDecode(utf8.decode(response.payload!.runes.toList())));
    onNotificationClick.add(message);
  }

  void onNotificationClickListener(message_class.Message message) async {
    if (message.actionModule != null && message.actionTable != null) {
      final path =
          await handleAction(message.actionModule!, message.actionTable!);
      QR.to(
          "fr.myecl.titan://$path?actionModule=${message.actionModule!}&actionTable=${message.actionTable!}");
    }
  }
}

@pragma("vm:entry-point")
void onDidReceiveBackgroundNotificationResponse(
    NotificationResponse response) async {
  if (response.payload == null) {
    return;
  }
  final message = message_class.Message.fromJson(
      jsonDecode(utf8.decode(response.payload!.runes.toList())));
  if (message.actionModule != null && message.actionTable != null) {
    final provider = providers[message.actionModule];
    if (provider == null) {
      return;
    }
    final information = provider[message.actionTable];
    if (information == null) {
      return;
    }
    final path = information.item1;
    QR.to(
        "fr.myecl.titan://$path?actionModule=${message.actionModule!}&actionTable=${message.actionTable!}");
  }
}
