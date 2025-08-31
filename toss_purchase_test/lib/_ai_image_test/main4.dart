import 'package:class_purchase_test/_ai_image_test/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AI 이미지 이해시키기",
      initialRoute: "/",
      routes: {
        "/": (context) => const MainPage(),
      });
  }
}
