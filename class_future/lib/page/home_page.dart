import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic _text = "통신이 되면 보일 컨테이너입니다.";
  final _formKey = GlobalKey<FormState>();
  String? _id;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              height: 400,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _text,
                  style: TextStyle(
                      fontSize: 24,
                      color: isError ? Colors.redAccent : Colors.black),
                ),
              ),
            ),
          ),
          Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 200,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "id를 입력해주세요."),
                    onSaved: (newValue) {
                      _id = newValue;
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                alignment: Alignment.center,
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)),
                child: InkWell(
                  onTap: () {
                    _formKey.currentState?.save();
                    _getData().then((onValue) {
                      print(_text);

                      if ((_text = onValue.body.toString()).contains("{}")) {
                        _text =
                            "Error: 입력값이 유효한 '숫자'가 아니거나 요청한 API가 잘못 되었습니다. 한 번 더 확인해주세요.";
                        isError = true;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.dangerous, color: Colors.white),
                                SizedBox(width: 10),
                                Text("호출 실패",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ]),
                          backgroundColor: Colors.redAccent,
                        ));
                      } else {
                        isError = false;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Row(children: [
                                  Icon(Icons.check_circle, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text("호출 성공!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                                backgroundColor: Colors.green));
                      }
                      setState(() {});
                    });
                  },
                  child: Text(
                    "값 가져오기",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              width: 360,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.white),
                    SizedBox(width: 20),
                    Text(
                      "id를 입력하지 않으면 전체 값이 출력됩니다.",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ]),
        ],
      )),
    );
  }

  Future<http.Response> _getData() async {
    var url = "http://jsonplaceholder.typicode.com/todos/$_id";
    http.Response response = await http.get(Uri.parse(url));
    return response;
  }
}
