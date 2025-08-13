abstract class Vehicle {
  String brand;

  Vehicle(this.brand);

  // 추상 메서드
  void start(); // 강제성을 제공해야 할 때

  void displayInfo() {
    print("브랜드 명 : ${brand}");
  }
}

class Car extends Vehicle {
  Car(String brand) : super(brand);

  @override
  void start() {
    print("${brand} 자동차가 시동을 겁니다.");
  }
}

class Flyable {
  void fly() {}
}

class Swimmable {
  void swim() {}
}

class Dock implements Flyable, Swimmable {
  @override
  void fly() {
    print("오리 비행");
  }

  @override
  void swim() {
    print("오리 수영");
  }
}
