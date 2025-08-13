import 'dart:io';

import 'package:class_camera_v2/helpers/image_helper.dart';
import 'package:class_camera_v2/styles/app_styles.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _selectedImage;
  String statusMessage = "사진을 선택하거나 촬영하세요";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('카메라 앱'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/list");
                },
                icon: Icon(Icons.list))
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.grey[300],
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  statusMessage,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "이미지가 없습니다",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 12.0,
                  runSpacing: 8.0,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _takePhoto,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('카메라'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _pickFromGallery,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('갤러리'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: (_selectedImage != null && !_isLoading)
                          ? _saveToGallery
                          : null,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('저장'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: (_selectedImage != null && !_isLoading)
                          ? _uploadToServer
                          : null,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('서버로 전송'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 사진 촬영
  Future<void> _takePhoto() async {
    setState(() {
      _isLoading = true;
      statusMessage = AppStyles.cameraLoading;
    });
    final File? image = await ImageHelper.takePhoto();

    setState(() {
      _isLoading = false;

      if (image != null) {
        _selectedImage = image;
        statusMessage = "사진 촬영 완료";
      } else {
        statusMessage = "사진 촬영이 취소 되었습니다.";
      }

      _resetMessageAfterDelay();
    });
  }

  // 일정 시간 후 상태 메시지를 기본값으로 돌리는 기능
  void _resetMessageAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          statusMessage = AppStyles.defaultMessage;
          _isLoading = false;
        });
      }
    });
  }

  // 갤러리 이미지 선택
  Future<void> _pickFromGallery() async {
    setState(() {
      _isLoading = true;
      statusMessage = AppStyles.galleryLoading;
    });
    final File? image = await ImageHelper.pickFromGallery();

    setState(() {
      _isLoading = false;

      if (image != null) {
        _selectedImage = image;
        statusMessage = "갤러리 이미지 선택 완료";
      } else {
        statusMessage = "갤러리 이미지 선택이 취소되었습니다.";
      }

      _resetMessageAfterDelay();
    });
  }

  // 갤러리 저장
  Future<void> _saveToGallery() async {
    setState(() {
      _isLoading = true;
      statusMessage = AppStyles.saveLoading;
    });
    await ImageHelper.saveToGallery(_selectedImage!.path);
    _selectedImage = null;

    _resetMessageAfterDelay();
  }

  // 서버 업로드
  Future<void> _uploadToServer() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
      statusMessage = "서버에 업로드 중..";
    });

    Map<String, dynamic> response =
        await ImageHelper.uploadToServer(_selectedImage!);
    print(response);
    _selectedImage = null;
    _resetMessageAfterDelay();
  }
}
