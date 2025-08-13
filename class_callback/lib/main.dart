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
  String displayText = "여기는 부모 위젯 영역입니다.";

  void handleReceiver(String msg) {
    setState(() {
      // 화면을 다시 그려달라는 요청 -> Swing의 repaint()와 똑같다 보면 됨
      displayText = "${msg} 콜백됨";
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
            Expanded(flex: 1, child: ChildA(onCallback: handleReceiver)),
            Expanded(flex: 1, child: ChildB(onCallback: handleReceiver)),
          ],
        ),
      ),
    );
  }
}

class ChildA extends StatelessWidget {
  final String message = "Child A";
  Function(String msg) onCallback;

  ChildA({required this.onCallback, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          onCallback(message);
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          color: Colors.orange,
          child: Text(
            "Child A",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}

class ChildB extends StatelessWidget {
  final String message = "Child B";
  Function(String msg) onCallback;

  ChildB({required this.onCallback, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          onCallback(message);
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          color: Colors.redAccent,
          child: Text(
            "Child B",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
