void main() {
  // 1. 원의 넓이를 구하는 함수
  double radius = 10.3;
  print("반지름: ${radius}cm");
  print("원의 넓이: ${getCircleArea(radius)}cm²");
  print("=================================");

  // 2. 직사각형의 면적을 구하는 함수
  double width = 5.1;
  double length = 10;
  print("직사각형의 가로 길이: ${width}cm");
  print("직사각형의 세로 길이: ${length}cm");
  print("직사각형의 넓이: ${getSquareArea(width, length)}cm²");
}

double getCircleArea(double radius) {
  return radius * radius * 3.14;
}

double getSquareArea(double width, double length) {
  return width * length;
}
