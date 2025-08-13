import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String statusMessage = "사진 저장하기";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    statusMessage,
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: _takePhoto,
                      icon: Icon(
                        Icons.camera_alt,
                        size: 50,
                      )),
                  IconButton(
                      onPressed: _openGallery,
                      icon: Icon(
                        Icons.photo,
                        size: 50,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _takePhoto() async {
    try {
      setState(() {
        statusMessage = "카메라 준비중 ...";
      });

      // 갤러리 접근 권한 확인 요청
      if (!await Gal.hasAccess()) {
        await Gal.requestAccess();
      }

      // 카메라 접근 권한 확인 요청
      // source -> 사진 촬영, 갤러리 이미지 선택
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        print("저장 경로 : ${image.path}");

        setState(() {
          statusMessage = "사진을 저장 중 ...";
        });

        await Gal.putImage(image.path).then((onValue) {
          setState(() {
            statusMessage = "사진 저장 완료";
          });
        });
      }
    } catch (e) {
      statusMessage = "오류가 발생했습니다.";
      print("오류가 발생했습니다.");

      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          statusMessage = "사진 저장 하기";
        });
      });
    }
  }

  void _openGallery() async {
    setState(() {
      statusMessage = "갤러리 실행 중...";
    });

    if (!await Gal.hasAccess()) {
      await Gal.requestAccess();
    }
    Gal.open();
  }
}
