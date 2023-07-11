import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myecl/tools/functions.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

abstract class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject()
    ..listen(onNotificationClickListener);

  Future<void> init() async {
    _localNotificationService
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
    tz.initializeTimeZones();
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
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    final details =
        await _localNotificationService.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotificationClick.add(details.notificationResponse!.payload);
    }
  }

  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("fr.myecl.titan", "TitanNotification",
            channelDescription: "Notifications channel forr Titan",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    return NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
  }

  Future<void> showNotification(String id, String title, String body) async {
    await _localNotificationService.show(
        generateIntFromString(id), title, body, await _notificationDetails());
  }

  Future<void> showNotificationWithPayload(
      String id, String title, String body, String payload) async {
    await _localNotificationService.show(
        generateIntFromString(id), title, body, await _notificationDetails(),
        payload: payload);
  }

  Future<void> showScheduledNotification(
      String id, String title, String body, DateTime date) async {
    await _localNotificationService.zonedSchedule(
        generateIntFromString(id),
        title,
        body,
        tz.TZDateTime.from(date, tz.local),
        await _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> showPeriodicNotification(String id, String title, String body,
      String? payload, RepeatInterval repeatInterval) async {
    await _localNotificationService.periodicallyShow(generateIntFromString(id),
        title, body, repeatInterval, await _notificationDetails(),
        payload: payload, androidAllowWhileIdle: true);
  }

  Future<void> showNotificationWithImage(String id, String title, String body,
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
            channelDescription: "Notifications channel forr Titan",
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
        const AndroidNotificationChannelGroup('com.my.app.alert1', 'mychannel1');
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

  Future<void> cancelNotificationById(String id) async {
    await _localNotificationService.cancel(generateIntFromString(id));
  }

  Future<void> cancelAllNotifications() async {
    await _localNotificationService.cancelAll();
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    print("Notification received: $id, $title, $body, $payload");
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) async {
    if (response.payload == null) {
      return;
    }
    if (response.payload!.isNotEmpty) {
      onNotificationClick.add(response.payload!);
    }
  }

  static void onNotificationClickListener(String? payload) {
    if (payload == null) {
      return;
    }
    if (payload.isNotEmpty) {
      print("Notification clicked: $payload");
      // do something
    }
  }
}
