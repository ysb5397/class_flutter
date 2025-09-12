import 'package:class_websocket_flutter/data/models/chat_message.dart';
import 'package:flutter/material.dart';

class ChatMessageItem extends StatelessWidget {
  final ChatMessage message;
  final String currentUsername;
  const ChatMessageItem(
      {required this.message, required this.currentUsername, super.key});

  @override
  Widget build(BuildContext context) {
    if (message.isSystemMessage) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12)),
            child: Text(
              message.content,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ),
        ),
      );
    }

    final isMyMessage = message.isMyMessage(currentUsername);
    if (isMyMessage) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              message.formattedTime,
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                    minWidth: 60,
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.all(12),
                child: Text(
                  message.content,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(children: [
                  Text(message.sender, style: TextStyle(color: Colors.black)),
                  Text(
                    message.content,
                    style: TextStyle(color: Colors.black),
                  )
                ]),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              message.formattedTime,
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      );
    }
  }
}
