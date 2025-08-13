class Dog {
  String? name = "test";
  int? age = 20;
  String? color;
  int thirsty = 100;

  void drinkWater(Water w) {
    thirsty = thirsty - 50;
    w.drink();
  }
}

class Water {
  double liter = 2.0;

  void drink() {
    liter = liter - 0.5;
  }
}

void main() {
  Dog dog = Dog();
  Water water = Water();
  print("이름 : ${dog.name ?? "익명"}");
  print("나이 : ${dog.age ?? 0}");
  print("색상 : ${dog.color ?? "white"}");
  print("목마름 : ${dog.thirsty}");

  print("=============================");
  // dog.thirsty = dog.thirsty - 50;

  dog.drinkWater(water);
}
