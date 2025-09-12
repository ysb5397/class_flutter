import 'package:class_websocket_flutter/pages/chat/widgets/chat_message_item.dart';
import 'package:class_websocket_flutter/providers/local/chat_message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessageList extends ConsumerWidget {
  final ScrollController scrollController;
  const ChatMessageList({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatMessageProvider);

    return ListView.builder(
        controller: scrollController,
        itemCount: chatState.messages.length,
        itemBuilder: (context, index) {
          return ChatMessageItem(
              message: chatState.messages[index],
              currentUsername: chatState.username);
        });
  }
}
