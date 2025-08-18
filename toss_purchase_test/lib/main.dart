import 'package:class_purchase_test/screens/main_screen.dart';
import 'package:class_purchase_test/screens/toss_purchase_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const MainScreen(),
        "/purchase": (context) => const TossPurchaseScreen()
      },
    );
  }
}
