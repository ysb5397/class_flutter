import 'dart:convert';
import 'dart:io';

import 'package:class_camera/helper/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
// path 패키지는 파일 경로를 다루는 유틸리티 패키지

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? _selectedImage;
  String statusMessage = "사진을 선택하거나 촬영하세요";
  bool _isLoading = false;
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("카메라 앱"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  statusMessage,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                color: Colors.grey,
                                size: 80,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "이미지가 없습니다.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          )),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _buildTextButton("카메라", Icons.camera_alt),
                    _buildTextButton("갤러리", Icons.photo_library),
                    _buildTextButton("서버로 전송", Icons.file_upload),
                    _buildTextButton("저장", Icons.save),
                  ],
                ))
          ],
        )),
      ),
    );
  }

  // 사진 저장
  void _savePhoto() async {
    try {
      if (!await Gal.hasAccess()) {
        await Gal.requestAccess();
      }

      setState(() {
        statusMessage = "사진 저장 중";
        _isLoading = true;
      });

      if (_image != null) {
        Gal.putImage(_image!.path);

        setState(() {
          statusMessage = "사진 저장 완료!";
          _isLoading = false;
          _selectedImage = null;
        });
      } else {
        setState(() {
          statusMessage = "저장할 사진이 없습니다.";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        statusMessage = "사진 저장 중 오류가 발생했습니다.";
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 갤러리에서 가져오기
  void _openGallery() async {
    try {
      if (!await Gal.hasAccess()) {
        await Gal.requestAccess();
      }

      setState(() {
        statusMessage = "갤러리 실행 중";
        _isLoading = true;
      });

      _image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 85);

      if (_image != null) {
        setState(() {
          _selectedImage = File(_image!.path);
          statusMessage = "이미지 선택 완료";
          _isLoading = false;
        });
      } else {
        setState(() {
          statusMessage = "이미지 선택이 취소되었습니다.";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        statusMessage = "갤러리 실행 중 오류가 발생했습니다.";
        _isLoading = false;
      });
    }
  }

  // 카메라로 사진촬영
  void _takePhoto() async {
    setState(() {
      _isLoading = true;
      statusMessage = "카메라 준비중..";
    });

    try {
      if (!await Gal.hasAccess()) {
        await Gal.requestAccess();
      }

      _image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 85);

      if (_image != null) {
        setState(() {
          statusMessage = "카메라 촬영 완료";
          _isLoading = false;
          _selectedImage = File(_image!.path);
        });
      } else {
        setState(() {
          statusMessage = "카메라 촬영 취소됨";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        statusMessage = "카메라 사용 중 오류가 발생했습니다.";
        _isLoading = false;
      });
    }
  }

  Color _buildColor(IconData iconData) {
    if (iconData == Icons.camera_alt) {
      return Colors.blue;
    } else if (iconData == Icons.photo_library) {
      return Colors.green;
    } else if (iconData == Icons.save) {
      return _selectedImage == null || _isLoading == true
          ? Colors.grey
          : Colors.orange;
    } else if (iconData == Icons.file_upload) {
      return Colors.deepPurpleAccent;
    } else {
      return Colors.grey;
    }
  }

  Widget _buildTextButton(String text, IconData iconData) {
    return Container(
      width: 180,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: _buildColor(iconData),
          borderRadius: BorderRadius.circular(30)),
      child: TextButton(
        onPressed: () {
          if (iconData == Icons.camera_alt) {
            _takePhoto();
          } else if (iconData == Icons.photo_library) {
            _openGallery();
          } else if (iconData == Icons.file_upload) {
            _uploadToServer();
          } else if (iconData == Icons.save) {
            _savePhoto();
          }
        },
        child: Row(
          children: [
            Icon(iconData),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                  color: iconData != Icons.save
                      ? Colors.white
                      : _selectedImage == null || _isLoading == true
                          ? Colors.black38
                          : Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
      statusMessage = '서버로 업로드 중..';
    });

    var url = Uri.parse('http://192.168.0.78:8080/api/images');
    var body = json.encode(
        {"fileName": _selectedImage, "imageData": _selectedImage!.path});
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
  }

  Future<http.Response> _getImage(int id) async {
    var url = Uri.parse('http://192.168.0.78:8080/api/images/$id');
    var response = await http.get(url);
    return response;
  }

  Future<void> _uploadToServer() async {
    if (_selectedImage == null) return null;

    setState(() {
      _isLoading = true;
      statusMessage = "서버로 업로드 중...";
    });

    // 통신
    final result = ImageHelper.uploadToServer(_selectedImage!);

    setState(() {
      _isLoading = false;
      statusMessage = "사진 업로드 완료";
    });
  }
}
