import 'package:class_websocket_flutter/pages/chat/widgets/chat_connection_status.dart';
import 'package:class_websocket_flutter/pages/chat/widgets/chat_input_field.dart';
import 'package:class_websocket_flutter/pages/chat/widgets/chat_message_item.dart';
import 'package:class_websocket_flutter/pages/chat/widgets/chat_message_list.dart';
import 'package:class_websocket_flutter/providers/local/chat_message_provider.dart';
import 'package:class_websocket_flutter/providers/local/connection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/chat_message.dart';

class ChatBody extends ConsumerStatefulWidget {
  const ChatBody({super.key});

  @override
  ConsumerState<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends ConsumerState<ChatBody> {
  final _editingController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(connectionStateProvider.notifier).connect();
    });
  }

  void _sendMessage() {
    final content = _editingController.text;
    if (content.isEmpty) return;
    _editingController.clear();
    ref.read(chatMessageProvider.notifier).sendMessage(content);
  }

  @override
  void dispose() {
    _editingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(chatMessageProvider, (previous, next) {
      // 자동 스크롤 내리는 기능
      if (previous != null && previous.messages.length < next.messages.length) {
        _scrollToBottom();
      }
    });

    return Column(
      children: [
        ChatConnectionStatus(),
        Expanded(child: ChatMessageList(scrollController: _scrollController)),
        ChatInputField(
            controller: _editingController, onSendMessage: _sendMessage),
      ],
    );
  }
}
