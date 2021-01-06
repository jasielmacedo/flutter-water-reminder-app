import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

class LocalNotificationManager {
  static LocalNotificationManager get instance => _instance;
  static LocalNotificationManager _instance;

  static void init() {
    _instance = LocalNotificationManager();
  }

  factory LocalNotificationManager() {
    if (_instance == null)
      _instance = LocalNotificationManager._createInstance();
    return _instance;
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  InitializationSettings initializationSettings;
  BehaviorSubject<ReceivedNotification>
      get didReceiveLocalNotificationSubject =>
          BehaviorSubject<ReceivedNotification>();

  LocalNotificationManager._createInstance() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (Platform.isIOS) _resolveIOSPermissions();

    _initializePlatform();
  }

  void _resolveIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(alert: true, badge: true, sound: true);
  }

  void _initializePlatform() {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('ic_launcher');

    IOSInitializationSettings iOSInitializationSettings =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification:
                (int id, String title, String body, String payload) async {
              ReceivedNotification notifications = ReceivedNotification(
                  id: id, title: title, body: body, payload: payload);

              didReceiveLocalNotificationSubject.add(notifications);
            });

    initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);
  }

  void setOnNotificationReceive(Function onNotificationReceive) {
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  void setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> instantShowNotification({
    int id: 0,
    String title: 'Water Drink Reminder',
    String body: 'let\'s get hydrated',
    String payload,
  }) async {
    var platformChannelSpecifics = _platformSpecifics();

    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<void> repeatNotification({
    int id: 0,
    String title: 'Water Drink Reminder',
    String body: 'let\'s get hydrated',
    String payload,
  }) async {
    var platformChannelSpecifics = _platformSpecifics();

    await flutterLocalNotificationsPlugin.periodicallyShow(
        id, title, body, RepeatInterval.hourly, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  NotificationDetails _platformSpecifics() {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'water_reminder_notif',
      'water_reminder_notif',
      'Channel for Water Reminder notification',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
  }
}

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;
  ReceivedNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}
