import 'package:class_google_map_v1/models/saved_marker.dart';
import 'package:class_google_map_v1/services/storage_service.dart';
import 'package:flutter/material.dart';

class MarkerListScreen extends StatefulWidget {
  const MarkerListScreen({super.key});

  @override
  State<MarkerListScreen> createState() => _MarkerListScreenState();
}

class _MarkerListScreenState extends State<MarkerListScreen> {
  List<SavedMarker> _markers = [];
  final StorageService _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    try {
      final markers = await _storageService.findMarkers();
      setState(() {
        _markers = markers;
        print(_markers);
      });
    } catch (e) {
      print("실행 오류");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_markers.isEmpty) {
      print("마커가 없습니다.");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("저장된 장소 ${_markers.length}개"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: _markers.length,
          itemBuilder: (context, index) {
            final savedMarker = _markers[index];
            return Card(
              margin: const EdgeInsets.all(12),
              child: ListTile(
                leading: Icon(
                  Icons.place,
                  color: Colors.redAccent,
                ),
                title: Text(savedMarker.name),
                subtitle: Text(
                    "위도: ${savedMarker.latitude}\n경도: ${savedMarker.longitude}"),
                trailing: IconButton(
                  onPressed: () async {
                    _storageService.deleteOneMarker(savedMarker.id);
                    await _loadMarkers();
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  print("선택된 마커로 자동 이동 처리");
                  Navigator.of(context).pop(savedMarker);
                },
              ),
            );
          }),
    );
  }
}
