import 'package:class_google_map_v1/screens/map_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Map",
      debugShowCheckedModeBanner: false,
      home: const MapScreen(),
    );
  }
}
