void main() {
  // List
  List<int> nums = [1, 2, 3, 5, 10, 3];

  for (int i = 0; i < nums.length; i++) {
    print("${i + 1}번째 - ${nums.elementAt(i)}");
  }

  print(nums.map((i) => i)); // -> for 문과 다르게 return이 가능
  print(nums.where((i) => i < 4)); // -> 필터링 연산으로 쓸 수 있는 where

  List<int> nums2 = [...nums];

  print("========================");
  print(nums2.map((i) => i));

  // Map
  Map<String, String> map = {"name": "test", "address": "abc"};
  map.forEach((key, value) => print("키 : ${key} / 값 : ${value}"));

  // Set
  Set<int> set = {1, 4, 6, 10, 3};

  for (int i = 0; i < set.length; i++) {
    print("${i + 1}번째 - ${set.elementAt(i)}");
  }

  print(set.map((i) => i));
}
