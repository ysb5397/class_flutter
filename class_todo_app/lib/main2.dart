import 'package:class_todo_app/todo_view_model.dart';
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
  final TodoViewModel _todoViewModel = TodoViewModel();

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
                IconButton(
                    onPressed: () {
                      int lastIndex = _todoViewModel.todos.length + 1;
                      _todoViewModel.addTodo(lastIndex, _controller.text);
                      setState(() {
                        _controller.clear();
                      });
                    },
                    icon: Icon(Icons.add)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _todoViewModel.todos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListTile(
                      title: Text(_todoViewModel.todos[index].title),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              _todoViewModel.removeTodo(index);
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
