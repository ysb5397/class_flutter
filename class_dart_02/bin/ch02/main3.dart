void main() {
  Chef c1 = Chef("셰프")..cook();
  // c1.cook(); -> 이렇게 두 줄로 안 써도 가능
}

class Chef {
  String name;

  Chef(this.name);

  void cook() {
    print("요리를 시작합니다.");
  }
}
