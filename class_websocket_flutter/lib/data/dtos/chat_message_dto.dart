import '../models/chat_message.dart';

class ChatMessageDto {
  final String id;
  final String content;
  final String sender;
  final String type;
  final String timestamp;

  ChatMessageDto({
    required this.id,
    required this.content,
    required this.sender,
    required this.type,
    required this.timestamp
  });

  // Json에서 Map 구조로 변환한 뒤, Map 구조에서 DTO 클래스를 생성(메시지 수신)
  factory ChatMessageDto.fromJson(Map<String, dynamic> json) {
    return ChatMessageDto(
      id: json['id'] as String,
      content: json['content'] as String,
      sender: json['sender'] as String,
      type: json['type'] as String,
      timestamp: json['timestamp'] as String
    );
  }

  // DTO 객체를 json으로 변환 시 사용(메시지 송신)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'sender': sender,
      'type': type,
      'timestamp': timestamp,
    };
  }

  // Model 객체를 DTO로 변환
  factory ChatMessageDto.fromModel(ChatMessage model) {
    return ChatMessageDto(
      id: model.id,
      content: model.content,
      sender: model.sender,
      type: model.type.toString(),
      timestamp: model.timestamp.toString(),
    );
  }

  // DTO를 Model 객체로 변환
  ChatMessage toModel() {
    return ChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      content: content,
      sender: sender,
      type: MessageType.CHAT,
      timestamp: DateTime.now(),
    );
  }
}