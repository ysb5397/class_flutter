import 'package:class_camera_v2/screens/camera_screen.dart';
import 'package:class_camera_v2/screens/image_detail_screen.dart';
import 'package:class_camera_v2/screens/image_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "카메라 앱",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: "/list",
      routes: {
        "/": (context) => const CameraScreen(),
        "/list": (context) => const ImageListScreen(),
        "/detail": (context) => const ImageDetailScreen(),
      },
    );
  }
}
