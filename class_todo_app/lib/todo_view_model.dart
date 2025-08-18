// ViewModel 클래스
// View 상태와 UI 관련 로직을 관리
import 'package:class_todo_app/todo.dart';

class TodoViewModel {
  // 화면과 관련된 데이터를 관리
  List<Todo> todos = [];

  // 할 일 추가 메서드
  void addTodo(int index, String title) {
    final newTodo = Todo(id: index, title: title);
    todos.add(newTodo);
  }

  // 할 일 삭제 메서드
  void removeTodo(int index) {
    todos.removeAt(index);
  }
}
