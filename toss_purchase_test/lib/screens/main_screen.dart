import 'package:class_purchase_test/helper/discord_helper.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final DiscordHelper _discordHelper = DiscordHelper();
  int _statusCode = 204;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("토스 결제 테스트", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue[100],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$_statusCode",
            style: TextStyle(
              fontSize: 50,
              color: _statusCode == 204 ? Colors.amber : _statusCode == 200 ? Colors.green : Colors.red
            ),),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.indigoAccent
            ),
            onPressed: () async {
            _statusCode = await _discordHelper.getWebhookToken();
            _statusCode = await _discordHelper.sendMessageByWebhook();
            setState(() {});
          }, child: Text("디스코드 메시지 보내기", style: TextStyle(color: Colors.white),),),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue
              ),
              onPressed: () async {
                Navigator.pushNamed(context, "/purchase");
              }, child: Text("토스 결제 요청 보내기", style: TextStyle(color: Colors.white),),),
          ]
        ),
      ),
    );
  }
}
