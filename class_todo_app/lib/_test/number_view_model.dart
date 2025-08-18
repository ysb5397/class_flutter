import 'package:flutter/material.dart';

import 'number.dart';

class NumberViewModel {
  Number number = Number(numberCount: 0);

  void increaseNumber() {
    number.numberCount++;
  }

  void decreaseNumber() {
    if (number.numberCount > 0) {
      number.numberCount--;
    } else {
      print("${DateTime.now()} : 0보다 낮게 설정할 수 없습니다.");
    }
  }
}
