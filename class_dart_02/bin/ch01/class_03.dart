void main() {
  List<String> footballPlayers = ['a', 'b', 'c'];

  footballPlayers.forEach((player) {
    print(player);
  });

  print("============================");
  footballPlayers.forEach((player) => print("요소 : ${player}"));

  // 람다식 단점
  // 아래처럼 분기 및 복잡한 함수는 람다식을 쓰기 어렵다.
  int substract(int a, int b) {
    if (a > b) {
      return a - b;
    } else {
      return b - a;
    }
  }
}

int add1(int n1, int n2) {
  return n1 + n2;
}

int sub1(int n1, int n2) {
  return n1 - n2;
}

double div1(int n1, int n2) {
  return n1 / n2;
}

int add(int n1, int n2) => n1 + n2;

int sub(int n1, int n2) => n1 - n2;

double div(int n1, int n2) => n1 / n2;
