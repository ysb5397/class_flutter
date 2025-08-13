import 'dart:math';

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
      home: Scaffold(
        appBar: AppBar(title: Text("드래그 기능 만들어보기")),
        body: DraggableBox(),
      ),
    );
  }
}

class DraggableBox extends StatefulWidget {
  const DraggableBox({super.key});

  @override
  State<DraggableBox> createState() => _DraggableBoxState();
}

class _DraggableBoxState extends State<DraggableBox> {
  double _xOffset = 0.0;
  double _yOffset = 0.0;

  // 객체가 생성될 때 단 한 번만 호출되는 메서드
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int randomColorId = 0;

  List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 드래그가 업데이트 될 때 호출되는 콜백
      onPanUpdate: (details) {
        setState(() {
          _xOffset += details.delta.dx;
          _yOffset += details.delta.dy;
          randomColorId = Random().nextInt(6);
        });
      },
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 500,
            child: Stack(
              children: [
                Positioned(
                  left: _xOffset,
                  top: _yOffset,
                  child: Container(
                    color: colors[randomColorId],
                    width: 150,
                    height: 150,
                    child: Text("드래그 해보세요."),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  _xOffset = 0.0;
                  _yOffset = 0.0;
                });
              },
              child: Text(
                "초기화",
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    backgroundColor: Colors.red),
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: 위젯 트리에서 제거될 때 호출되며, State 객체가 영구적으로 제거
    super.dispose();
  }
}
