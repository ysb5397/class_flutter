import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences 예제',
      debugShowCheckedModeBanner: false,
      home: CountStorage(),
    );
  }
}

class CountStorage extends StatefulWidget {
  const CountStorage({super.key});

  @override
  State<CountStorage> createState() => _CountStorageState();
}

class _CountStorageState extends State<CountStorage> {
  int _counter = 0;
  final String _counterKey = "count_value";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("예제"),
        backgroundColor: Colors.orange[200],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              _getCounter();
            },
            icon: Icon(Icons.refresh),
            tooltip: "데이터 새로고침",
          ),
          IconButton(
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text("삭제 알림"),
                    content: Text(
                      "삭제하면 모든 데이터를 복구할 수 없으며, 0으로 초기화 됩니다. 그래도 삭제하시겠습니까?",
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("취소")),
                      TextButton(
                          onPressed: () {
                            _removeCounter();
                            _counter = 0;
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("모든 데이터 삭제됨!")));
                          },
                          child: Text("확인")),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete_forever),
            tooltip: "모든 데이터 삭제",
          )
        ],
      ),
      body: _buildBody(context),
      bottomNavigationBar: Container(
        color: Colors.green[400],
        padding: EdgeInsets.all(16),
        child: Text(
          textAlign: TextAlign.center,
          "팁: 앱을 종료했다가 다시 실행해보세요.\n저장한 값이 그대로 유지됩니다.",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          color: Colors.blue[200],
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                "카운터",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.orange[200], shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    "$_counter",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_counter > 0) {
                          _counter -= 1;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red[200],
                              content: Text(
                                "0보다 낮게 설정할 수 없습니다",
                                style: TextStyle(color: Colors.white),
                              )));
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[300]),
                    child: Text(
                      "-1",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _counter += 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[300]),
                    child: Text(
                      "+1",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _saveCounter().then((onValue) {
                      if (onValue) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green[200],
                            content: Text(
                              "저장 성공!",
                              style: TextStyle(color: Colors.white),
                            )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red[200],
                            content: Text(
                              "저장 실패...",
                              style: TextStyle(color: Colors.white),
                            )));
                      }
                    });
                  },
                  label: Text("저장하기"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  // 비동기로 동작
  Future<void> _removeCounter() async {
    try {
      SharedPreferences prefers = await SharedPreferences.getInstance();
      setState(() {
        prefers.clear();
      });
    } catch (e) {
      print("삭제 중 오류");
    }
  }

  Future<void> _getCounter() async {
    try {
      SharedPreferences prefers = await SharedPreferences.getInstance();
      setState(() {
        _counter = prefers.getInt(_counterKey) != null
            ? prefers.get(_counterKey) as int
            : 0;
      });
    } catch (e) {
      print("로드 중 오류");
    }
  }

  Future<bool> _saveCounter() async {
    try {
      SharedPreferences prefers = await SharedPreferences.getInstance();
      bool success = await prefers.setInt(_counterKey, _counter);
      return success;
    } catch (e) {
      return false;
    }
  }
}
