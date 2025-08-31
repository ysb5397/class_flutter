import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const urlIpAddress = "192.0.168.???";
  static const baseUrl = "http://$urlIpAddress/api/test/gemini";
  final _controller = TextEditingController();
  File? _selectedImage = null;
  bool _isImageLoading = false;
  bool _isResultLoading = false;
  String _geminiResponseText = "";
  Dio dio = Dio(
      BaseOptions(headers: {"Content-Type": "application/json;charset=utf-8"}));

  StreamSubscription? _sseSubscription;

  @override
  void initState() {
    super.initState();
    _subscribeToSseEvents(userId: 1);
  }

  void _subscribeToSseEvents({required int userId}) {
    // 이전 구독이 있다면 취소
    _sseSubscription?.cancel();

    final url = "$baseUrl/subscribe/$userId";
    print("✅ SSE 구독 시작: $url"); // 구독 시작 로그 추가

    _sseSubscription = SSEClient.subscribeToSSE(
      method: SSERequestType.GET,
      url: url,
      header: {"Accept": "text/event-stream"},
    ).listen(
      (event) {
        // 서버에서 보낸 이벤트를 여기서 계속 듣고 있는다.
        print("✅ SSE 이벤트 수신! Name: ${event.event}, Data: ${event.data}");

        final eventName = event.event ?? '';

        if (eventName == 'connect') {
          // 서버에서 보낸 '첫인사' (연결 성공 메시지)
          print('SSE 연결 성공: ${event.data}');
        } else if (eventName == 'AI Response') {
          // AI 응답이 조각조각 날아올 때마다
          setState(() {
            _isResultLoading = false; // 응답이 오기 시작하면 로딩 상태 해제
            _geminiResponseText += event.data ?? ''; // 기존 텍스트에 계속 추가!
          });
        }
      },
      onError: (error) {
        print("❌ SSE 에러 발생: $error");
        setState(() {
          _isResultLoading = false;
          _geminiResponseText = "SSE 연결에 실패했습니다: $error";
        });
      },
    );
  }

  @override
  void dispose() {
    _sseSubscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      // [수정 1] SingleChildScrollView로 감싸서 키보드 오버플로우 방지
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              width: double.infinity,
              height: 500,
              child: _isResultLoading == true
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.black54,
                          ),
                          SizedBox(height: 30),
                          Text("잠시만 기다려 주세요.. AI 응답을 요청 중입니다."),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(children: [Text(_geminiResponseText)]),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  // TextFormField가 너무 길어서 Row 밖으로 나가는 것을 방지하기 위해 Expanded로 감싸줌
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _selectedImage == null
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300]),
                          width: 50,
                          height: 50,
                          child: _isImageLoading == true
                              ? const Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 4,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : null,
                        )
                      : ClipOval(
                          clipBehavior: Clip.hardEdge,
                          child: Image.file(
                            _selectedImage!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    // [수정 2] onPressed 로직을 대폭 단순화
                    onPressed: () async {
                      if (_selectedImage == null || _controller.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("이미지와 프롬프트를 모두 입력해주세요.")));
                        return;
                      }

                      setState(() {
                        _isResultLoading = true;
                        _geminiResponseText = ""; // 이전 응답 초기화
                      });

                      try {
                        final encodingResponse = await _imageEncoding();

                        if (encodingResponse["success"]) {
                          // AI에게 질문을 '보내기만' 한다.
                          // 응답은 initState에서 연결한 SSE 리스너가 알아서 받는다.
                          await _sendToGemini(
                            imageData: encodingResponse["body"],
                            userId: 1,
                          );
                        } else {
                          setState(() {
                            _isResultLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(encodingResponse["errorMessage"] ??
                                  "이미지 인코딩 실패")));
                        }
                      } catch (e) {
                        setState(() {
                          _isResultLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("AI에게 요청을 보내는 데 실패했습니다: $e")));
                      }
                    },
                    style: TextButton.styleFrom(
                        side: BorderSide(color: Colors.black12)),
                    child: Text("AI랑 대화하기")),
                IconButton(
                    onPressed: () => _putImage(),
                    style: IconButton.styleFrom(
                        side: BorderSide(color: Colors.black12)),
                    icon: Icon(Icons.image))
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Future<Map<String, dynamic>> _imageEncoding() async {
    try {
      if (_selectedImage == null) {
        return {"success": false, "errorMessage": "업로드된 이미지가 없습니다."};
      }
      final bytes = await _selectedImage!.readAsBytes();
      final base64String = base64Encode(bytes);
      final extension = path.extension(_selectedImage!.path).toLowerCase();
      String mimeType = "image/jpeg";
      if (extension == ".png") {
        mimeType = "image/png";
      } else if (extension == ".gif") {
        mimeType = "image/gif";
      }

      final Map<String, dynamic> jsonData = {
        // [수정 4] mimeType을 파일이름이 아닌 실제 타입으로 수정
        "mimeType": mimeType,
        "imageData": base64String
      };
      return {"success": true, "body": jsonData};
    } catch (e) {
      return {"success": false, "errorMessage": "이미지 처리 중 오류 발생: $e"};
    } finally {
      // 이 함수에서는 _isResultLoading 상태를 직접 바꾸지 않도록 수정
      // setState(() { _isResultLoading = false; });
    }
  }

  Future<void> _sendToGemini({
    required Map<String, dynamic> imageData,
    required int userId,
  }) async {
    try {
      final requestData = {
        "contents": [
          {
            "parts": [
              {
                "inline_data": {
                  "mime_type": imageData["mimeType"],
                  "data": imageData["imageData"]
                }
              },
              {"text": _controller.text},
            ]
          }
        ]
      };

      // [수정 4] 질문을 보낼 API 주소를 '/chat/'으로 변경!
      await dio.post(
        "$baseUrl/chat/$userId",
        data: json.encode(requestData),
      );
      // 이 메소드는 응답을 기다릴 필요 없이, 요청을 보내기만 하면 역할 끝!
    } catch (e) {
      // 에러가 나면 로딩 상태를 해제하고 사용자에게 알림
      setState(() {
        _isResultLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("AI에게 요청을 보내는 데 실패했습니다: $e")));
    }
  }

  Future<void> _putImage() async {
    try {
      setState(() {
        _isImageLoading = true;
      });

      if (!await Gal.hasAccess()) {
        await Gal.requestAccess();
      }

      XFile? image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 85); // 이미지 사이즈 제한은 여기서 빼는 게 더 나을 수 있음

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      // 에러 처리
    } finally {
      setState(() {
        _isImageLoading = false;
      });
    }
  }
}
