import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  // -> Single... 애니메이션을 적절히 컨트롤 함

  late AnimationController _controller;
  late Animation _animation;
  int _count = 0;
  Color _background = Colors.orange;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      // 동기화하여 성능 최적화
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 1.0, end: 10.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInBack)
          ..addListener(() {
            setState(() {
              // 애니메이션을 진행할 때 마다 화면을 업데이트
            });
          }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text(
                  "버튼을 누른 횟수 : $_count",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Transform.scale(
                  scale: _animation.value,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _background),
                      onPressed: _incrementCounter,
                      child: Text(
                        "카운트",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _randomColor() {
    final random = Random();
    return Color.fromARGB(
        255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
  }

  void _incrementCounter() {
    setState(() {
      _count++;
      _background = _randomColor();
    });

    _controller.forward().then((onValue) {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // 자원 해제
    super.dispose();
  }
}
