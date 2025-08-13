import 'package:flutter/material.dart';

// 간격
const double gap_xl = 40;
const double gap_l = 30;
const double gap_m = 20;
const double gap_s = 10;
const double gap_xs = 5;

// 헤더 높이
const double header_height = 620;

// MediaQuery 클래스로 화면 사이즈 받기 가능
double getBodyWidth(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.7;
}
