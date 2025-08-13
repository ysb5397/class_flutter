import 'dog.dart';

void main() {
  Dog dog = Dog();
  // Person p1 = Person("테스트", 100);
  Person p2 = Person(money: 100, name: "테스트");
}

class Person {
  String? name;
  int? money;

  // dart에서는 생성자 오버로딩을 지원하지 않음
  // Person(this.name, this.money);
  // 선택적 매개변수를 활용해서 생성자 오버로딩을 선언할 필요가 없다.
  Person({this.name, this.money});
}
