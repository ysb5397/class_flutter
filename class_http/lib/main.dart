import 'package:class_http/models/todo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  Todo? todo;
  fetchTodo().then((onValue) {
    if (onValue.statusCode == 200) {
      print("=== 통신 성공! ===");
      print(onValue.statusCode);
      print(onValue.body);
      Map<String, dynamic> jsonMap = json.decode(onValue.body);

      todo = Todo.fromJson(jsonMap);
      print("======== TODO ========");
      print("유저 ID : ${todo?.userId}");
      print("ID : ${todo?.id}");
      print("Title : ${todo?.title}");
      print("Completed : ${todo?.completed}\n");
    } else {
      print("=== 통신 실패... ===");
      print(onValue.statusCode);
      print(onValue.request);
    }
  });
}

Future<http.Response> fetchTodo() async {
  String url = "http://jsonplaceholder.typicode.com/todos/1";
  http.Response response = await http.get(Uri.parse(url));
  return response;
}
