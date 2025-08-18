import 'package:class_todo_app/_test/number_view_model.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NumberViewModel _numberViewModel = NumberViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: Text("숫자 카운팅"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("카운팅 횟수", style: TextStyle(fontSize: 20)),
              Text(
                "${_numberViewModel.number.numberCount}",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _numberViewModel.increaseNumber();
                            });
                          },
                          child: Text(
                            "숫자 증가",
                            style: TextStyle(fontSize: 20),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            setState(() {
                              _numberViewModel.decreaseNumber();
                            });
                          },
                          child: Text(
                            "숫자 감소",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
