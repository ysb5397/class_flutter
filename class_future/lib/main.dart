void main() async {
  // dart 비동기 프로그래밍 개념 잡기
  // 동기적 방식 : 모든 코드가 순차적
  // 비동기적 방식 : 코드가 순차적으로 진행됨을 보장 못함

  // 키워드 future - async / await -> 1회성 응답을 돌려받을 때 사용
  print("test1");
  // 비동기 함수를 필요에 의해서 동기적으로 변경하는 방법
  var data = await fetchData();
  print("${data}");
  print("test2");
}

Future<String> fetchData() {
  return Future.delayed(
    Duration(seconds: 5),
    () {
      print("fetchData 메서드 호출됨.");
      return "5초 Data";
    },
  );
}
