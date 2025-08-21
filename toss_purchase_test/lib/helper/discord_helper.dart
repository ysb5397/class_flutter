import 'dart:convert';

import 'package:http/http.dart' as http;

class DiscordHelper {
  final String _baseUrl = "https://discordapp.com/api/webhooks";
  final String _identifyUrl = "/";
  late String _webhookId;
  late String _webhookToken;

  Future<int> getWebhookToken() async {
    final response = await http.get(Uri.parse("$_baseUrl$_identifyUrl"));
    Map<String, dynamic> responseData = json.decode(response.body);

    _webhookId = responseData["id"] as String;
    _webhookToken = responseData["token"] as String;
    return response.statusCode;
  }

  Future<int> sendMessageByWebhook() async {
    final requestBody = {
      "username": "테스트용",
      "embeds": [
        {"title": "엠베드 테스트", "description": "엠베드 설명 테스트", "color": 0xff0000}
      ]
    };

    final response = await http.post(
        Uri.parse("$_baseUrl/$_webhookId/$_webhookToken"),
        headers: {"Content-Type": "application/json;charset=utf-8"},
        body: json.encode(requestBody));

    return response.statusCode;
  }
}
