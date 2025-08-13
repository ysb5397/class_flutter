void main() {
  String? maybeName;
  int length = maybeName?.length ?? 0;
  print("${length}");

  String? name = getName();
  name = name?.toLowerCase() ?? "TEST".toLowerCase();
  print("${name}");

  //-----------------------------
  // String? name2 = null;
  String? name2 = "ㅅㄷㄴㅅ";
  // 강제적으로 null값이 아님을 보장하는 ! 키워드
  // 그러나, 개발자의 의도와는 다르게 null 값이 들어오면 예외가 터진다.
  String name3 = name2!;
}

String? getName() {
  return null;
}
