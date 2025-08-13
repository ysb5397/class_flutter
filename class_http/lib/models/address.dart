import 'geo.dart';

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Map<String, dynamic> geo;

  Address.info(Map<String, dynamic> addressMap)
      : street = addressMap["street"],
        suite = addressMap["suite"],
        city = addressMap["city"],
        zipcode = addressMap["zipcode"],
        geo = addressMap["geo"];
}
