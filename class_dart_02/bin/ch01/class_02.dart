void test2(Function f) {
  f();
}

void main() {
  var test = (int num) {
    return num * 100;
  }; // 선언을 하더라도 사용할 방법이 없다.

  // 하지만 dart 언어는 일급 객체를 지원한다.
  // dart 언어는 익명 함수를 변수에 담을 수 있다.
  print(test(10));
  print(test.runtimeType);

  test2(() {
    print("hi");
  });
  // var 같은 경우가 아니라면(int, String 등등) 명시적으로 선언을 해주어야 한다.
  int Function(int) b = (int number) {
    return number * number;
  };

  // return 타입 생략 가능
  Function(int) bool1 = (int testNum) {
    return testNum > 10;
  };

  // 3...
  // dart는 파라미터 타입 생략도 가능
  Function sub = (a, b) {
    return a * b;
  };

  print('=================');
  print('${sub('1', 2)}');

  // 4
  var multiply = (a, b) {
    return a * b;
  };

  print('${multiply('1', 2)}');

  // 5
  // 파라미터에 함수를 전달할 수 있다.

  int add(int a, int b) {
    return a + b;
  }

  int multiply2(int a, int b) {
    return a * b;
  }

  void performOperation(int a, int b, int Function(int, int) operation) {
    print(operation(a, b));
  }

  performOperation(10, 5, add);
}
