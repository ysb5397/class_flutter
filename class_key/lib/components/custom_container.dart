import 'dart:math';

import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final String name;
  const CustomContainer(this.name, {super.key});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  late Color color = randomColor();

  @override
  Widget build(BuildContext context) {
    print(widget.name);
    return Container(
        alignment: Alignment.center,
        height: 150,
        width: 150,
        color: color,
        child: Text(
          widget.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ));
  }

  Color randomColor() {
    final Random random = Random();
    return Color.fromARGB(random.nextInt(256), random.nextInt(256),
        random.nextInt(256), random.nextInt(256));
  }
}
