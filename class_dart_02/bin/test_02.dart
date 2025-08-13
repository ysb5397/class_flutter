void main() {
  int j = 2;

  for (int i = 1; i < 11; i++) {
    if (i < 10 && j < 10) {
      print("${j} * ${i} = ${j * i}");
    } else if (j < 10) {
      print("========== ${j}단 =========");
      j++;
      i = 0;
    } else {
      break;
    }
  }
}
