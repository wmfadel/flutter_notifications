import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationsHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var initializationSettingsIOS;
  var initializationSettingsAndroid;

  NotificationsHelper() {
    initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
      if (payload.startsWith('EVENT')) {
        int id = int.parse(payload.split(',')[1]);
        debugPrint('Navigate to event with id $id');
      } else if (payload.startsWith('COMMUNITY')) {
        int id = int.parse(payload.split(',')[1]);
        debugPrint('Navigate to community with id $id');
      } else if (payload.startsWith('PROFILE')) {
        int id = int.parse(payload.split(',')[1]);
        debugPrint('Navigate to user profile with id $id');
      }
    }
  }

  showNotification({
    required String? title,
    required String? body,
    required String? payload,
  }) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '1', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  showScheduledNotification() async {
    tz.initializeTimeZones();
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'scheduled title',
      'scheduled body',
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      platformChannelSpecifics,
      payload: 'showed after 5 sec',
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  showPeriodicNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'repeating channel id',
        'repeating channel name',
        'repeating description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(1, 'repeating title',
        'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics);
  }

  cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
