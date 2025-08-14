import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CloudHelper {
  static final String _baseUrl = "http://192.168.0.78:8080";
  static final String _endPoint = "/api/recruits";

  static Future<Map<String, dynamic>> getApplies() async {
    var response = await http.get(Uri.parse("$_baseUrl$_endPoint"),
        headers: {"Content-type": "application/json;charset=utf-8"});
    print(response.statusCode);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);

      return {
        "statusCode": response.body,
        "msg": "성공",
        "body": responseData["body"]
      };
    } else {
      throw new Exception("데이터 수집 중 오류가 발생했습니다.");
    }
  }
}
