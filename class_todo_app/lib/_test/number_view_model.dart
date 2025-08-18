import 'package:flutter/material.dart';

import 'number.dart';

class NumberViewModel {
  int number = 0;

  void increaseNumber() {
    number++;
  }

  void decreaseNumber(context) {
    if (number > 0) {
      number--;
    } else {
      print("${DateTime.now()} : 0보다 낮게 설정할 수 없습니다.");
    }
  }
}
