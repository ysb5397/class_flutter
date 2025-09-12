import 'package:class_websocket_flutter/providers/local/connection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatConnectionStatus extends ConsumerWidget {
  const ChatConnectionStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connection = ref.watch(connectionStateProvider);
    return Container(
      width: double.infinity,
      height: 50,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: connection.isConnected ? Colors.greenAccent : Colors.redAccent,
      ),
      child: Text(
        "${connection.status}",
        style: TextStyle(color: const Color.fromARGB(255, 128, 128, 128)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
