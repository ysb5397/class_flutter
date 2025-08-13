import 'package:flutter/material.dart';

void main() {
  // 괄호 안의 위젯을 루트 위젯으로 만들어줌
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const를 생략하지 않는게 좋다.(성능상의 이유)
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp을 호출(내부에 편리한 기능이 많음)
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StorePage(),
    );
  }
}

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Text(
                    "Woman",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "Kids",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "Shoes",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "Bag",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
                child:
                    Image.asset("assets/images/bag.jpeg", fit: BoxFit.cover)),
            SizedBox(
              height: 0.5,
            ),
            Expanded(
                child:
                    Image.asset("assets/images/cloth.jpeg", fit: BoxFit.cover)),
          ],
        ),
      ),
    );
  }
}
