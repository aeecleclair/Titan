import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

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
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelId', 'channelName',
            channelDescription: "decription",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    return const NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
  }

  Future<void> showNotification(int id, String title, String body) async {
    await _localNotificationService.show(
        id, title, body, await _notificationDetails());
  }

  Future<void> showNotificationWithPayload(
      int id, String title, String body, String payload) async {
    await _localNotificationService
        .show(id, title, body, await _notificationDetails(), payload: payload);
  }

  Future<void> showScheduledNotification(
      int id, String title, String body, DateTime date) async {
    await _localNotificationService.zonedSchedule(id, title, body,
        tz.TZDateTime.from(date, tz.local), await _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<List<PendingNotificationRequest>> pendingNotificationRequests() async {
    return await _localNotificationService.pendingNotificationRequests();
  }

  Future<void> cancelNotificationById(int id) async {
    await _localNotificationService.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _localNotificationService.cancelAll();
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    print(title);
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) async {
    print(response);
    if (response.payload == null) {
      return;
    }
    if (response.payload!.isNotEmpty) {
      onNotificationClick.add(response.payload!);
    }
  }
}

LocalNotificationService listenToNotiffication() {
  final LocalNotificationService localNotificationService =
      LocalNotificationService();
  localNotificationService.init();
  localNotificationService.onNotificationClick.listen((payload) {
    if (payload == null) {
      return;
    }
    if (payload.isNotEmpty) {
      // do something
    }
  });
  return localNotificationService;
}
