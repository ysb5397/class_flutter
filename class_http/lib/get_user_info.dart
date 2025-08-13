import 'package:class_http/models/address.dart';
import 'package:class_http/models/company.dart';
import 'package:class_http/models/geo.dart';
import 'package:class_http/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  User user;
  Address address;
  Geo geo;
  Company company;

  getUserData().then((onValue) {
    if (onValue.statusCode == 200) {
      print("===== 통신 성공! =====");
      print(onValue.statusCode);
      List<dynamic> userList = json.decode(onValue.body);

      for (int i = 0; i < userList.length; i++) {
        Map<String, dynamic> userMap = userList[i];
        user = User.info(userMap);
        address = Address.info(userMap["address"]);
        geo = Geo.info(userMap["address"]["geo"]);
        company = Company.info(userMap["company"]);

        print("======= 유저 정보 =======");
        print("유저 ID : ${user.id}");
        print("이름 : ${user.name}");
        print("유저 이름 : ${user.username}");
        print("이메일 : ${user.email}");
        print("휴대 전화 : ${user.phone}");
        print("웹 사이트 : ${user.website}\n");

        print("도로명 주소 : ${address.street}");
        print("상세 주소 : ${address.suite}");
        print("거주 도시 : ${address.city}");
        print("우편 번호 : ${address.zipcode}");
        print("위도 : ${geo.lat}");
        print("경도 : ${geo.lng}\n");

        print("회사 이름 : ${company.name}");
        print("회사 슬로건 : ${company.catchPhrase}");
        print("회사 내부 목표 : ${company.bs}\n");
      }
    } else {
      print("===== 통신 실패... =====");
      print(onValue.statusCode);
      print(onValue.request);
    }
  });
}

Future<http.Response> getUserData() async {
  String url = "http://jsonplaceholder.typicode.com/users";
  http.Response response = await http.get(Uri.parse(url));
  return response;
}
