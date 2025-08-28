import 'package:class_purchase_test/_alarm_test/local_push_notifications.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    listenNotifications();
    super.initState();
  }

  // 푸시 알림 스트림의 데이터를 listen
  void listenNotifications() {
    LocalPushNotifications.notificationStream.stream.listen((String? payload) {
      if (payload != null) {
        print("Received payload: $payload");
        Navigator.pushNamed(context, "/message", arguments: payload);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("푸시 알림 테스트"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                LocalPushNotifications.showSimpleNotification(
                    title: "일반 알림 제목", body: "일반 알림 내용", payload: "일반 알림 데이터");
              },
              child: const Text("일반 푸시 알림"),
            ),
            ElevatedButton(
              onPressed: () {
                LocalPushNotifications.showPeriodicNotifications(
                    title: "반복 알림 제목", body: "반복 알림 내용", payload: "반복 알림 데이터");
              },
              child: const Text("반복 푸시 알림"),
            ),
            ElevatedButton(
              onPressed: () {
                LocalPushNotifications.showScheduleNotification(
                    title: "일정 알림 제목", body: "일정 알림 내용", payload: "일정 알림 데이터");
              },
              child: const Text("일정 푸시 알림"),
            ),
            TextButton(
                onPressed: () {
                  LocalPushNotifications.cancel(1);
                },
                child: const Text("반복 푸시 알림 끄기")),
            TextButton(
                onPressed: () {
                  LocalPushNotifications.cancelAll();
                },
                child: const Text("모든 푸시 알림 끄기")),
          ],
        ),
      ),
    );
  }
}
