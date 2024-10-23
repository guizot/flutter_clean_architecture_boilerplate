import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_service.dart';

class PushNotificationService {

  int id = 0;

  late final FirebaseMessaging msg;
  PushNotificationService() {
    msg = FirebaseMessaging.instance;
  }

  void init() async {
    try{
      msg.setForegroundNotificationPresentationOptions(
        alert: true,
        sound: true,
        badge: true,
      );
      settingNotification();
      FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
      FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
        debugPrint("event.notification?.title : ${event.notification?.title}");
        debugPrint("event.notification?.body : ${event.notification?.body}");
        const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          icon: '@mipmap/launcher_icon',
        );
        const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
        await flutterLocalNotificationsPlugin.show(id++, event.notification?.title, event.notification?.body, notificationDetails, payload: 'item x');
      });
      msg.getToken().then((value) => debugPrint("token : $value"));

    } catch (e) {
      debugPrint('Error initializing Firebase: $e');
    }
  }

  void settingNotification() async {
    await msg.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );
  }

  static Future<void> onBackgroundMessage(RemoteMessage event) async {
    debugPrint("on background msh: ${event.messageId}");
  }

}


