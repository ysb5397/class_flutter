import 'package:class_market/ch01/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(const CarrotMarketUI());
}

class CarrotMarketUI extends StatelessWidget {
  const CarrotMarketUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "carrot",
      home: MainScreen(),
      theme: theme(),
    );
  }
}
