// 'TODO' 데이터를 표현하는 모델 클래스
import 'dart:convert';

class Todo {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  // 기본 생성자 - 빈 객체 생성용
  Todo();

  // 명명된 생성자(이름이 있음)
  Todo.fromJson(Map<String, dynamic> json)
      : userId = json["userId"],
        id = json["id"],
        title = json["title"],
        completed = json["completed"];

  // 디버깅용 -> toString 재정의
  @override
  String toString() {
    return 'Todo{userId: $userId, id: $id, title: $title, completed: $completed}';
  }
}
