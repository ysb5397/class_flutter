import 'dart:convert';

import 'package:flutter/material.dart';

import '../helpers/image_helper.dart';

class ImageDetailScreen extends StatefulWidget {
  const ImageDetailScreen({super.key});

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  // 리스트에서 넘겨준 데이터를 받는 코드를 작성하고, 즉 그 ID값으로 http.get 요청
  // -> 통신으로 받은 데이터로 다시 렌더링
  late Future<dynamic> _imageDetail;
  int? _imageId;

  // 1st
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // 2nd
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _imageId = ModalRoute.of(context)?.settings.arguments as int?;

    if (_imageId != null) {
      _imageDetail = ImageHelper.getImageDetail(_imageId);
    }
  }

  // 3rd
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("이미지 상세보기"),
      ),
      body: FutureBuilder(
        future: _imageDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("이미지를 불러오는데 실패했습니다."),
            );
          } else {
            final imageData = snapshot.data["body"];
            final base64String = imageData["imageData"];
            final cleanBase64 = base64String.split(",").last;
            final bytes = base64Decode(cleanBase64);

            return Container(
              child: Image.memory(bytes, fit: BoxFit.cover),
            );
          }
        },
      ),
    );
  }
}
