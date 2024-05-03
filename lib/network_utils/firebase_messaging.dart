import 'dart:convert';
import 'dart:developer';

import 'package:atherium_saloon_app/models/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsSubscription {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@drawable/ic_launcher');
  static DarwinInitializationSettings initializationSettingsIOS =
      const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    defaultPresentSound: true,
    defaultPresentAlert: true,
    defaultPresentBadge: true,
    defaultPresentBanner: true,
    requestProvisionalPermission: true,
  );
  static InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  static Future<void> showNotification(context) async {
    try {
      await setup();
      await firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        announcement: true,
        criticalAlert: true,
      );
      log('Fcm subscribe');
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    } catch (error) {
      //
    }
  }

  static Future<void> fcmSubscribe({required String topicId}) async {
    try {
      await firebaseMessaging.subscribeToTopic(topicId);
      // await firebaseMessaging.subscribeToTopic('bCh4DtuF9J7FX2D7aHIm');
      log("++Token subscribe++$topicId");
    } catch (error) {
      log(error.toString());
    }
  }

  static Future<void> fcmUnSubscribe({required String appUserId}) async {
    try {
      await firebaseMessaging.unsubscribeFromTopic(appUserId);
      await firebaseMessaging.unsubscribeFromTopic('bCh4DtuF9J7FX2D7aHIm');

      log("++Token unSubscribe++$appUserId");
    } catch (error) {
      log(error.toString());
    }
  }

  static Future<void> createNotification(
      {required NotificationModel notification}) async {

    DocumentReference docRef = firestore.collection('new_notification').doc();
    notification.id = docRef.id;
    await docRef.set(notification.toMap());
  }

  static Future<void> setup() async {
    const androidInitializationSetting = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    final DarwinInitializationSettings iosInitializationSetting =
        DarwinInitializationSettings(
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentBanner: true,
      defaultPresentList: true,
      defaultPresentSound: true,
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestProvisionalPermission: true,
      requestSoundPermission: true,

      // ...
      notificationCategories: [
        DarwinNotificationCategory(
          'demoCategory',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('id_1', 'Action 1'),
            DarwinNotificationAction.plain(
              'id_2',
              'Action 2',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.destructive,
              },
            ),
            DarwinNotificationAction.plain(
              'id_3',
              'Action 3',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
            ),
          ],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
          },
        )
      ],
    );
    final initSettings = InitializationSettings(
        android: androidInitializationSetting, iOS: iosInitializationSetting);
    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {
        log('background tapped');
        notificationTapBackground(details);
      },
      onDidReceiveNotificationResponse: (details) {
        log('tapped');
      },
    );
  }

  static showDefualtLocalNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    // AndroidNotification? android = message.notification!.android;
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'YOUR_DEFAULT_CHANNEL_ID',
      'high_importance_channel',
      importance: Importance.max,
      playSound: true,
    );
    AndroidNotificationDetails androidNotificationDetail =
        AndroidNotificationDetails(
      channel.id, channel.name,
      importance: Importance.max,
      channelDescription: 'your channel description',
      icon: "@mipmap/ic_launcher",
      priority: Priority.high,
      ticker: 'ticker',
      // other properties...
    );
    DarwinNotificationDetails iosNotificationDetail =
        const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            presentBanner: true);
    if (notification != null) {
      var notificationDetails = NotificationDetails(
        android: androidNotificationDetail,
        iOS: iosNotificationDetail,
      );

      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetails,
        payload: message.data.toString(),
      );
    }
  }

  static showAdoreLocalNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    // AndroidNotification? android = message.notification!.android;
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'ADORE_CHANNEL_ID',
      'Adore Notification Channel',
      importance: Importance.max,
      playSound: true,
    );

    AndroidNotificationDetails androidNotificationDetail =
        AndroidNotificationDetails(
      channel.id, channel.name,
      importance: Importance.max,
      channelDescription: 'Adore channel description',
      icon: "@mipmap/ic_launcher",
      priority: Priority.high,
      ticker: 'ticker',

      // other properties...
    );
    if (notification != null) {
      var notificationDetails = NotificationDetails(
        android: androidNotificationDetail,
      );
      flutterLocalNotificationsPlugin.show(notification.hashCode,
          notification.title, notification.body, notificationDetails,
          payload: message.data.toString());
    }
  }

  static showPsstLocalNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    // AndroidNotification? android = message.notification!.android;
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'PSST_CHANNEL_ID',
      'Psst Notification Channel',
      importance: Importance.max,
      playSound: true,
    );
    AndroidNotificationDetails androidNotificationDetail =
        AndroidNotificationDetails(
      channel.id, channel.name,
      importance: Importance.max,
      channelDescription: 'Psst channel description',
      icon: "@mipmap/ic_launcher",
      priority: Priority.high,
      ticker: 'ticker',

      // other properties...
    );
    if (notification != null) {
      var notificationDetails = NotificationDetails(
        android: androidNotificationDetail,
      );
      flutterLocalNotificationsPlugin.show(notification.hashCode,
          notification.title, notification.body, notificationDetails,
          payload: message.data.toString());
    }
  }

  static showNotificationNoSound(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    // AndroidNotification? android = message.notification!.android;
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'no_sound_channel',
      'No Sound Channel',
      importance: Importance.min,
      playSound: false,
    );
    AndroidNotificationDetails androidNotificationDetail =
        AndroidNotificationDetails(
      channel.id, channel.name,
      importance: Importance.min,
      channelDescription: 'Channel with no sound',
      icon: "@mipmap/ic_launcher",
      priority: Priority.min,
      playSound: false,
      // other properties...
    );
    if (notification != null) {
      var notificationDetails = NotificationDetails(
        android: androidNotificationDetail,
      );
      flutterLocalNotificationsPlugin.show(notification.hashCode,
          notification.title, notification.body, notificationDetails,
          payload: message.data.toString());
    }
  }

  static onSelectNotification(
      NotificationResponse payload, BuildContext context) {
    var data = NotificationModel.fromJson(payload.payload!);
    log('>>>Navigate:$data');
  }

  static notificationTapBackground(NotificationResponse notificationResponse) {
    Map data = jsonDecode(notificationResponse.payload!);
    log('Notifiction type : ${data['type']}');
    log('>>>Navigate:$data');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // ignore: avoid_print
      log('notification action tapped with input: ${notificationResponse.payload.toString()}');
    }
  }
}
