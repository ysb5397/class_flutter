class Geo {
  String lat;
  String lng;

  Geo.info(Map<String, dynamic> geoMap)
      : lat = geoMap["lat"],
        lng = geoMap["lng"];
}
