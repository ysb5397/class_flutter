import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ParentsView(),
    );
  }
}

class ParentsView extends StatefulWidget {
  const ParentsView({super.key});

  @override
  State<ParentsView> createState() => _ParentsViewState();
}

class _ParentsViewState extends State<ParentsView> {
  String displayText = "숫자를 입력해주세요.";

  void handleReceiver(String msg) {
    setState(() {
      // 화면을 다시 그려달라는 요청 -> Swing의 repaint()와 똑같다 보면 됨
      displayText = "${msg}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  displayText,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Expanded(flex: 2, child: Keypad(onCallback: handleReceiver)),
          ],
        ),
      ),
    );
  }
}

class Keypad extends StatelessWidget {
  final String message = "Child A";
  Function(String msg) onCallback;

  Keypad({required this.onCallback, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        color: Colors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNumber("1"),
            _buildNumber("2"),
            _buildNumber("3"),
            _buildNumber("4"),
            _buildNumber("5"),
          ],
        ),
      ),
    );
  }

  Widget _buildNumber(String number) {
    return InkWell(
      onTap: () {
        onCallback(number);
      },
      child: Container(
        alignment: Alignment.center,
        width: 70,
        height: 70,
        child: Text(
          number,
          style: TextStyle(fontSize: 40),
        ),
        color: Colors.white,
      ),
    );
  }
}
