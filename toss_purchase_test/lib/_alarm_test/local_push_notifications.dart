import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalPushNotifications {
  // 안드로이드용 아이콘
  final androidSetting = AndroidInitializationSettings("app_icon");

  // 플러그인 인스턴스 생성
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // 푸시 알림 스트림 생성
  static final StreamController<String?> notificationStream =
      StreamController<String?>.broadcast();

  // 푸시 알림을 탭했을 때 호출 되는 콜백 함수
  static void onNotificationTap(NotificationResponse notificationResponse) {
    notificationStream.add(notificationResponse.payload!);
  }

  // 플러그인 초기화
  static Future init() async {
    // Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // 안드로이드 푸시 알림 권한 요청
    if (Platform.isAndroid) {
      _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    }

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  // 일반 푸시 알림 보내기
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channel 1", "channel 1 name",
            channelDescription: "channel 1 description",
            importance: Importance.max,
            priority: Priority.high,
            ticker: "ticker");
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  // 매분마다 주기적인 푸시 알림 보내기
  static Future showPeriodicNotifications({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channel 2", "channel 2 name",
            channelDescription: "channel 2 description",
            importance: Importance.max,
            priority: Priority.high,
            ticker: "ticker");
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    print("반복 알림 메서드 진입");

    await showSimpleNotification(title: "반복알림", body: "반복 알림", payload: "반복알림");
    _flutterLocalNotificationsPlugin
        .periodicallyShow(1, title, body, RepeatInterval.everyMinute,
            notificationDetails, // 반복 간격 지정, 매 분마다 반복
            payload: payload,
            androidScheduleMode: AndroidScheduleMode.alarmClock)
        .then((onValue) {
      print("반복 알림 호출 성공");
    });
  }

  static Future showScheduleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    tz.initializeTimeZones(); // timezone 초기화
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails("channel 3", "channel 3 name",
                channelDescription: "your channel description",
                importance: Importance.max,
                priority: Priority.high,
                ticker: "ticker")),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload);
  }

  // 채널 ID에 해당하는 푸시 알림 취소
  static Future cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // 푸시 알림 전체 취소
  static Future cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
