import 'package:flutter/material.dart';

/// 모노리스 구조
void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _todos = [];

  void addTodo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todos.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void removeTodo(index) {
    setState(() {
      _todos.removeAt(index);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("오늘 해야 할 일"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 320,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "할일을 입력해주세요.",
                    ),
                  ),
                ),
                IconButton(onPressed: addTodo, icon: Icon(Icons.add)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListTile(
                      title: Text(_todos[index]),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              removeTodo(index);
                            });
                          },
                          icon: Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          )),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
