// 이미지 처리와 서버 업로드를 담당하는 헬퍼 클래스(비즈니스 클래스)
// 카메라 촬영, 갤러리 선택, 로컬 저장, 서버 업로드 기능 제공
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static const String _baseUrl = "http://192.168.0.132:8080";
  static const String _uploadEndpoint = "/api/images";

  // 카메라 사진 촬영
  static Future<File?> takePhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? imageFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );

      if (imageFile == null) return null;

      return File(imageFile.path);
    } catch (e) {
      print("카메라 촬영 오류 : $e");
      return null;
    }
  }

  // 이미지 선택
  static Future<File?> pickFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? imageFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (imageFile == null) return null;

      return File(imageFile.path);
    } catch (e) {
      print("갤러리 이미지 선택 오류 : $e");
      return null;
    }
  }

  // 갤러리에 이미지 저장
  static Future<bool> saveToGallery(String imagePath) async {
    try {
      if (!await Gal.hasAccess()) {
        await Gal.requestAccess();
      }

      await Gal.putImage(imagePath);
      return true;
    } catch (e) {
      print("이미지 저장 오류 : $e");
      return false;
    }
  }

  // 서버로 이미지 업로드 (Base64 접두사 포함)
  static Future<Map<String, dynamic>> uploadToServer(File image) async {
    try {
      // 1. 파일을 바이트 단위로 읽음
      final bytes = await image.readAsBytes();

      // 2. base64 인코딩
      final base64String = base64Encode(bytes);

      // 3. 확장자
      final extension = path.extension(image.path).toLowerCase();
      String mimeType = "image/jpeg";
      if (extension == ".png" || extension == ".jpg" || extension == ".gif") {
        String type = extension.replaceAll(".", "");
        mimeType = "image/$type";
      }

      // 4. base64
      final imageDataWithPrefix = "data:$mimeType;base64,$base64String";

      // 5. 파일이름, 이미지 데이터
      String fileName = path.basename(image.path);
      String tempExtension = fileName.substring(fileName.indexOf("."));
      fileName = "테스트$tempExtension";

      // 6. 서버 측으로 보낼 데이터 형식 준비
      final Map<String, dynamic> jsonData = {
        "fileName": fileName,
        "imageData": imageDataWithPrefix
      };

      final http.Response response = await http.post(
          Uri.parse("$_baseUrl$_uploadEndpoint"),
          headers: {"Content-Type": "application/json;charset=utf-8"},
          body: json.encode(jsonData));

      if (response.statusCode == 200) {
        return {
          "code": response.statusCode,
          "msg": "성공!",
          "body": json.decode(response.body)
        };
      }
      return {"code": response.statusCode, "msg": "실패...", "body": null};
    } catch (e) {
      return {"msg": "실패... / ${e.toString()}", "body": null};
    }
  }

  // 서버에서 전체 이미지 리스트 조회
  static Future<Map<String, dynamic>> getImageList() async {
    try {
      http.Response response = await http.get(
          Uri.parse("$_baseUrl$_uploadEndpoint"),
          headers: {"Content-Type": "application/json;charset=utf-8"});

      if (response.statusCode == 200) {
        final List<dynamic> imageList = json.decode(response.body);
        return {
          "code": response.statusCode,
          "msg": "목록 조회 성공",
          "body": imageList
        };
      } else {
        return {"code": response.statusCode, "msg": "목록 조회 실패", "body": null};
      }
    } catch (e) {
      return {"code": 500, "msg": "목록 조회 오류", "body": null};
    }
  }

  // 서버에서 특정 이미지 조회
  static Future<Map<String, dynamic>> getImageDetail(id) async {
    try {
      http.Response response = await http.get(
          Uri.parse("$_baseUrl$_uploadEndpoint/$id"),
          headers: {"Content-Type": "application/json;charset=utf-8"});

      if (response.statusCode == 200) {
        final image = json.decode(response.body);
        return {"code": response.statusCode, "msg": "이미지 조회 성공", "body": image};
      } else {
        return {"code": response.statusCode, "msg": "이미지 조회 실패", "body": null};
      }
    } catch (e) {
      return {"code": 500, "msg": "이미지 조회 오류", "body": null};
    }
  }
}
