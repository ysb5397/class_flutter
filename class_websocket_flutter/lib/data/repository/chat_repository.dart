import 'dart:convert';
import 'dart:io';
import '../../data/dtos/chat_message_dto.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import '../models/chat_message.dart';

// 웹 소켓 네트워크 담당
// 1. stomp client 초기화
// 2. 연결 성공 처리
// 3. 연결 해제 처리
// 4. 메시지 전송 처리
// 5. 메시지 수신 처리
// 6. 에러처리
class ChatRepository {
  late StompClient stompClient;

  // 플랫폼별 서버 주소 설정
  static String get serverUrl {
    if (Platform.isAndroid) {
      return "http://192.168.0.132:8080";
    } else if (Platform.isIOS) {
      return "http://localhost:8080";
    } else {
      return "http://localhost:8080";
    }
  }

  // 연결 상태 확인
  bool get isConnected => stompClient.connected;

  // 콜백 함수 만들기
  // 네트워크 이벤트를 상위 클래스에 알려주기 위함
  // 이 클래스의 목적은 네트워크 통신을 통해서 무슨 이벤트가 들어왔는지만 알면 된다
  // 그리고 이 이벤트를 받아서 처리하는건 상위 클래스가 결정
  void Function()? onConnected;
  void Function()? onDisconnected;
  void Function(String error)? onError;
  void Function(ChatMessage message)? onMessage;

  // 1. stomp client 초기화
  void init() {
    stompClient = StompClient(
      config: StompConfig(
        url: "$serverUrl/ws",
        onConnect: _handleConnected,
        onDisconnect: _handleDisconnected,
        onWebSocketError: (error) => onError?.call("연결 오류: $error"),
        useSockJS: true,
      ),
    );
  }

  // frame.body
  // frame.headers
  // frame.command
  void _handleConnected(StompFrame frame) {
    print("서버 연결 성공");
    _subscribeToMessage();
    onConnected?.call();
  }

  void _handleDisconnected(StompFrame frame) {
    onDisconnected?.call();
  }

  // 서버 연결
  void connect() {
    stompClient.activate();
  }

  // 서버 연결 해제
  void disconnect() {
    if (stompClient.connected) {
      stompClient.deactivate();
    }
  }

  // 메시지 전송
  void sendMessage(ChatMessage chatMessage) {
    if (!stompClient.connected) {
      onError?.call("서버 연결 실패");
      return;
    }

    final dto = ChatMessageDto.fromModel(chatMessage);
    final jsonBody = json.encode(dto);
    stompClient.send(destination: "/app/chat", body: jsonBody);
  }

  // 메시지 구독
  void _subscribeToMessage() {
    print("서버 메시지 구독 완료");
    stompClient.subscribe(
      destination: "/topic/message",
      callback: (frame) {
        if (frame.body == null) {
          return;
        }
        _handleMessage(frame.body!);
      },
    );
  }

  // 메시지 수신
  void _handleMessage(String messageBody) {
    try {
      print("들어온 메시지 확인 / 메시지 내용: $messageBody");
      final jsonData = json.decode(messageBody);
      final dto = ChatMessageDto.fromJson(jsonData);
      final model = dto.toModel();
      onMessage?.call(model);
    } on Exception catch (e) {
      print("에러 발생 : $e");
    }
  }
}
