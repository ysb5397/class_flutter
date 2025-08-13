import 'dart:convert';

import 'package:class_camera_v2/helpers/image_helper.dart';
import 'package:class_camera_v2/styles/app_styles.dart';
import 'package:flutter/material.dart';

class ImageListScreen extends StatefulWidget {
  const ImageListScreen({super.key});

  @override
  State<ImageListScreen> createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  late Future<List<dynamic>> _imageListFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageListFuture = _fetchImageList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _imageListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "데이터를 불러오는데 실패했습니다.",
                textAlign: TextAlign.center,
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "데이터가 없습니다.",
                textAlign: TextAlign.center,
              ),
            );
          } else {
            final List<dynamic> imageList = snapshot.data!;
            return ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                final image = imageList[index];
                return _buildImageList(image);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildImageList(image) {
    final id = image["id"] as int;
    final fileName = image["fileName"] as String;
    final base64String = image["imageData"] as String;
    final cleanBase64 = base64String.split(",").last;
    final bytes = base64Decode(cleanBase64);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      elevation: 2,
      child: ListTile(
        leading: Image.memory(
          bytes,
          fit: BoxFit.contain,
        ),
        title: Text(fileName),
        subtitle: Text("id : $id"),
        onTap: () {
          // 화면 이동 후 추가적으로 통신 요청을 한 번 더 함
          Navigator.pushNamed(context, "/detail", arguments: id);
        },
      ),
    );
  }

  // 서버에서 이미지 목록 가져오는 함수
  Future<List<dynamic>> _fetchImageList() async {
    final result = await ImageHelper.getImageList();
    if (result["code"] == 200) {
      return result["body"] as List<dynamic>;
    } else {
      throw Exception(result["msg"]);
    }
  }
}
