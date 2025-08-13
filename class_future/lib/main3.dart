import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  var data = fetchTodoList();
}

Future<http.Response> fetchTodo() async {
  const url = "http://jsonplaceholder.typicode.com/todos/10";
  Uri uri = Uri.parse(url);
  var response = await http.get(uri);
  print("${response}");
  return response;
}

Future<http.Response> fetchTodoList() async {
  const url = "http://jsonplaceholder.typicode.com/todos";
  var response = await http.get(Uri.parse(url));
  print(response.statusCode);
  print(response.headers);
  print(response.body);
  return response;
}
