import 'dart:convert';

import 'package:http/http.dart' as http;

class DiscordHelper {
  final String _webhookUrl = "https://discordapp.com/api/webhooks";
  final String _identifyUrl = "";
  Map<String, dynamic> _tokenInfos = {};
  late String _token;
  late String _id;

  Future<void> getWebhookToken() async {
    final response = await http.get(Uri.parse("$_webhookUrl$_identifyUrl"));
    _tokenInfos = json.decode(response.body);

    _token = _tokenInfos["token"];
    _id = _tokenInfos["id"];
    print(_token);
  }

  Future<void> sendWebhook(countNumber) async {
    final jsonData = {"content": countNumber, "username": "test"};

    final response = await http.post(
      Uri.parse("$_webhookUrl/$_id/$_token"),
      headers: {"Content-Type": "application/json;charset=utf-8"},
      body: json.encode(jsonData),
    );

    print(response.body);
  }
}
