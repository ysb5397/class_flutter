import 'package:class_key/components/custom_container.dart';
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
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> containers = [
    CustomContainer(
      "1",
      key: ValueKey(1),
    ),
    CustomContainer(
      "2",
      key: ValueKey(2),
    ),
    CustomContainer(
      "3",
      key: ValueKey(3),
    ),
  ];

  Widget extraContainer = const CustomContainer("Extra");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: containers,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (containers.length == 3) {
            containers.insert(0, extraContainer);
          } else if (containers.length == 4) {
            containers.removeAt(0);
          }
          setState(() {});
        },
        child: Icon(
          Icons.add_box_outlined,
          size: 42,
        ),
      ),
    );
  }
}
