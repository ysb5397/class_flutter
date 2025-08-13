import 'package:flutter/material.dart';

/// 앱에서 사용되는 모든 스타일과 상수를 관리하는 클래스
/// 일관된 디자인을 위해 중앙에서 관리
class AppStyles {
  // 인스턴스 생성 방지
  AppStyles._();

  // === 색상 상수 ===
  static const Color primaryColor = Colors.blue;
  static const Color cameraButtonColor = Colors.blue;
  static const Color galleryButtonColor = Colors.green;
  static const Color saveButtonColor = Colors.orange;
  static const Color backgroundColor = Colors.white;

  // === 텍스트 스타일 ===
  static const TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle noImageStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  // === 패딩과 마진 ===
  static const double defaultPadding = 16.0;
  static const double buttonSpacing = 12.0;
  static const double iconSize = 24.0;

  // === 문자열 상수 ===
  static const String defaultMessage = '사진을 선택하거나 촬영하세요';
  static const String cameraLoading = '카메라를 준비 중...';
  static const String galleryLoading = '갤러리를 여는 중...';
  static const String saveLoading = '이미지를 저장 중...';
  static const String saveSuccess = '이미지가 저장되었습니다!';
  static const String noImageText = '이미지가 없습니다';
}
