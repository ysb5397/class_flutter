void main() {
  // Animal(name: "고양이");
  Dog dog = Dog("흰둥이", "생선");
  print("이름 : ${dog.name}");
  print("음식 : ${dog.breed}");
}

class Animal {
  String name;

  Animal(this.name);
}

// initialize 기호 ':'
class Dog extends Animal {
  String breed;
  Dog(String name, String this.breed) : super(name);
}

// super 키워드는 부모 클래스의 생성자나 메서드를 호출할 때 사용할 수 있다.
