// 창고 데이터
import 'package:class_websocket_flutter/data/repository/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectionState {
  final bool isConnected;
  final String status;

  ConnectionState({required this.isConnected, required this.status});

  ConnectionState copyWith({bool? isConnected, String? status}) {
    return ConnectionState(
      isConnected: isConnected ?? this.isConnected,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'ConnectionState{isConnected: $isConnected, status: $status}';
  }
}

class ConnectionStateNotifier extends Notifier<ConnectionState> {

  late ChatRepository _chatRepository;

  ChatRepository get chatRepository => _chatRepository;

  @override
  ConnectionState build() {
    _chatRepository = ChatRepository();
    _setupCallbacks();
    _chatRepository.init();
    return ConnectionState(isConnected: false, status: "연결 준비중");
  }

  void _setupCallbacks() {
    _chatRepository.onConnected = () {
      state = state.copyWith(isConnected: true, status: "연결됨");
    };

    _chatRepository.onDisconnected = () {
      state = state.copyWith(isConnected: false, status: "연결 끊김");
    };

    _chatRepository.onError = (error) {
      state = state.copyWith(isConnected: false, status: "연결 오류: $error");
    };
  }

  void connect() {
    state = state.copyWith(status: "연결중");
    _chatRepository.connect();
  }

  void disconnect() {
    _chatRepository.disconnect();
  }
}

final connectionStateProvider = NotifierProvider<ConnectionStateNotifier, ConnectionState>(() => ConnectionStateNotifier());