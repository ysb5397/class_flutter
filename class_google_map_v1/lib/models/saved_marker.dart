class SavedMarker {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  SavedMarker._internal({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  // 1. static 저장소(캐시) 준비
  static final Map<String, SavedMarker> _cache = {};

  // 팩토링 생성자
  factory SavedMarker.fromMap(Map<String, dynamic> map) {
    String id = map["id"] as String;

    if (_cache.containsKey(id)) {
      return _cache[id]!;
    }

    final newMarker = SavedMarker._internal(
      id: id,
      name: map["name"],
      latitude: map["latitude"],
      longitude: map["longitude"],
    );

    print("캐시 저장");
    _cache[id] = newMarker;
    return newMarker;
  }

  // SharedPreferences 용도
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "latitude": latitude,
      "longitude": longitude
    };
  }
}
