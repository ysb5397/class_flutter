import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class ImageHelper {
  // 1. 서버 측 URL 설정
  static const String _baseUrl = "http://192.168.0.78:8080";
  static const String _uploadEndpoint = "/api/images";
  static String _extensionName = "jpeg";

  // 카메라로 사진촬영
  static Future<File?> _takePhoto() async {
    try {
      final XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 85);

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print("카메라 촬영 오류 $e");
      return null;
    }
  }

  // 서버측으로 업로드
  static Future<Map<String, dynamic>> uploadToServer(File imageFile) async {
    // 1. 파일을 바이트 단위로 변환
    final bytes = await imageFile.readAsBytes();

    // 2. Base64로 인코딩
    final base64String = base64Encode(bytes);

    // 3. 파일 확장자 추출
    final extension = path.extension(imageFile.path).toLowerCase();

    // Base64 -> data:/image/?;base64,JDKAJdjkadakSJka...
    String mimeType = "image/$_extensionName";

    if (extension != ".jpeg") {
      _extensionName = extension.replaceAll(".", "");
      mimeType = "image/$_extensionName";
    }

    final imageDataWithPrefix = "data:${mimeType};base64,$base64String";

    // 파일명 추출
    String fileName = path.basename(imageFile.path);

    final requestData = {
      "fileName": fileName,
      "imageData": imageDataWithPrefix
    };

    // http Post 요청
    final response = await http.post(Uri.parse("$_baseUrl$_uploadEndpoint"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: json.encode(requestData));

    // 로깅
    print("응답 코드 : ${response.statusCode}");
    print("응답 본문 : ${response.body}");

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return {"success": true, "msg": "이미지가 성공적으로 업로드 됨", "body": responseData};
    } else {
      return {"success": false, "msg": "이미지 업로드 실패"};
    }
  }

  // 서버쪽에서 받아오기
}
