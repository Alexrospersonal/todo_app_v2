import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import 'package:todo_app_v2/common/global_app.dart';
import 'package:todo_app_v2/common/utils/navigation.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const iOSinitSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      iOS: iOSinitSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _notificationTapForeground,
      onDidReceiveBackgroundNotificationResponse: _notificationTapBackground,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<void> _notificationTapForeground(
    NotificationResponse response,
  ) async {
    if (response.payload != null) {
      _navigateTo(response.payload!);
    }
  }

  @pragma('vm:entry-point')
  static void _notificationTapBackground(
    NotificationResponse response,
  ) {
    if (response.payload != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateTo(response.payload!);
      });
    }
  }

  static void _navigateTo(String route) {
    GlobalApp.navigatorKey.currentState?.pushNamed(route);
  }

  static Future<void> showInstantNotification(
    int id,
    String title,
    String body,
  ) async {
    const platformChannelSpecifics = NotificationDetails(
      iOS: DarwinNotificationDetails(presentSound: false),
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  static Future<void> showNotification(
    int id,
    String title,
    String body,
    DateTime scheduledTime,
    RouteNames route,
  ) async {
    const platformChannelSpecifics = NotificationDetails(
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      TZDateTime.from(scheduledTime, local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      payload: route.name,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
