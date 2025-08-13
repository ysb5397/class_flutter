import 'package:class_http/models/address.dart';

import 'company.dart';
// user.address['street']
// user.address.street
// user.address.geo.lat
class User {
  int id;
  String name;
  String username;
  String email;
  Map<String, dynamic> address;
  String phone;
  String website;
  Map<String, dynamic> company;

  User.info(Map<String, dynamic> userMap)
      : id = userMap["id"],
        name = userMap["name"],
        username = userMap["username"],
        email = userMap["email"],
        address = userMap["address"],
        phone = userMap["phone"],
        website = userMap["website"],
        company = userMap["company"];
}
