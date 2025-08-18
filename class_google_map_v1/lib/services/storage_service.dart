import 'dart:convert';

import 'package:class_google_map_v1/models/saved_marker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _markerKey = "saved_markers";

  // SaveAll
  Future<bool> saveMarkers(List<SavedMarker> markers) async {
    try {
      final prefers = await SharedPreferences.getInstance();

      print(markers);
      final markerListMap = markers.map((e) => e.toMap()).toList();
      print(markerListMap);
      final jsonStream = json.encode(markerListMap);
      print(jsonStream);
      return await prefers.setString(_markerKey, jsonStream);
    } catch (e) {
      return false;
    }
  }

  // SaveOne
  Future<bool> addMarker(SavedMarker newMarker) async {
    try {
      final markers = await findMarkers();

      if (markers.any((e) => e.id == newMarker.id)) {
        return false;
      }

      markers.add(newMarker);
      return await saveMarkers(markers);
    } catch (e) {
      return false;
    }
  }

  // Read
  Future<List<SavedMarker>> findMarkers() async {
    try {
      final prefers = await SharedPreferences.getInstance();
      final jsonData = prefers.getString(_markerKey);

      if (jsonData != null) {
        final List<dynamic> markerList = json.decode(jsonData);
        print(markerList);
        final markerMap =
            markerList.map((e) => SavedMarker.fromMap(e)).toList();
        return markerMap;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // DELETE
  Future<bool> deleteMarkers() async {
    try {
      final prefers = await SharedPreferences.getInstance();
      return await prefers.remove(_markerKey);
    } catch (e) {
      return false;
    }
  }

  // 특정 ID 값으로 마커 객체 하나를 삭제?
  Future<bool> deleteOneMarker(String markerId) async {
    try {
      final markers = await findMarkers();
      final updateMarkers =
          markers.where((marker) => marker.id != markerId).toList();

      return await saveMarkers(updateMarkers);
    } catch (e) {
      print("마커 삭제 오류");
      return false;
    }
  }
}
