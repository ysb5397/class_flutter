import 'package:cloud_rest/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CloudRest());
}

class CloudRest extends StatefulWidget {
  const CloudRest({super.key});

  @override
  State<CloudRest> createState() => _CloudRestState();
}

class _CloudRestState extends State<CloudRest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cloud Rest",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {"/": (context) => const MainScreen()},
    );
  }
}
