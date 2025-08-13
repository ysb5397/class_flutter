import 'package:class_login/components/logo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 200),
            Logo("Care Soft"),
            SizedBox(height: 50),
            TextButton(
                onPressed: () {
                  // 화면을 스택에서 제거
                  Navigator.pop(context);
                },
                child: Text("Get Started"))
          ],
        ),
      ),
    );
  }
}
