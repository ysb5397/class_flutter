// Mixin -> 여러 클래스에서 재사용할 수 있는 기능을 제공하는 방법
void main() {
  // Logger logger = Logger()..log("테스트");
  UserService userService = UserService()..createUser("테스트");

  // 자바 인터페이스 : 구현해야할 메서드의 명세만 제공(추상적)
  // Dart 믹스인 : 완성된 기능을 그대로 제공(구체적)
}

class UserService with Logger {
  void createUser(String name) {
    log("사용자 생성 시작 - ${name}");
    log("사용자 생성 완료");
  }
}

mixin Logger {
  void log(String message) {
    DateTime now = DateTime.now();
    print("현재 시간 : [${now}] / 메시지 : ${message}");
  }
}
