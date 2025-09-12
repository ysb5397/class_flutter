import 'package:class_websocket_flutter/data/repository/chat_repository.dart';
import 'package:class_websocket_flutter/providers/local/connection_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/chat_message.dart';

class ChatState {
  final List<ChatMessage> messages;
  final String username;

  ChatState({required this.messages, required this.username});

  ChatState copyWith({
    List<ChatMessage>? messages,
    String? username
  }) {
    return ChatState(messages: messages ?? this.messages, username: username ?? this.username);
  }
}

class ChatMessageNotifier extends Notifier<ChatState> {
late ChatRepository _chatRepository;

  @override
  ChatState build() {
    final connectionNotifier = ref.watch(connectionStateProvider.notifier);
    _chatRepository = connectionNotifier.chatRepository;
    _setupMessageCallback();
    return ChatState(messages: [ChatMessage.createSystem(content: "aaas")], username: "ysb5397");
  }

  void _setupMessageCallback() {
    _chatRepository.onMessage = (messageBody) {
      print("메시지 수신됨 : ${messageBody.content}");

      if (messageBody.sender == state.username) {
        return;
      }
      state = state.copyWith(messages: [...state.messages, messageBody]);
    };

    _chatRepository.onError = (error) {
      // TODO
    };

    _chatRepository.onDisconnected = () {
      // TODO
    };
  }

  void sendMessage(String content) {
    if (content.trim().isEmpty) return;

    ChatMessage message = ChatMessage.createChat(content: content, sender: state.username);
    state = state.copyWith(messages: [...state.messages, message]);
    _chatRepository.sendMessage(message);
  }
}

final chatMessageProvider = NotifierProvider<ChatMessageNotifier, ChatState>(() => ChatMessageNotifier());