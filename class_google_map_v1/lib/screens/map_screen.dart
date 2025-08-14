import 'package:class_google_map_v1/models/saved_marker.dart';
import 'package:class_google_map_v1/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // 1. 지도를 조작하기 위한 리모컨이 필요
  GoogleMapController? _controller;
  static const LatLng _initCenter = LatLng(35.1578, 129.0622);
  Set<Marker> _markerSet = {};
  final StorageService _storageService = StorageService();

  // Shared...
  List<SavedMarker> _savedMarkers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMarkers();
  }

  // 저장된 마커 불러오기
  Future<void> _loadMarkers() async {
    try {
      final loadedMarkers = await _storageService.findMarkers();

      setState(() {
        _savedMarkers = loadedMarkers;
        _markerSet.clear();
        loadedMarkers.map((marker) => {
              _markerSet.add(Marker(
                  markerId: MarkerId(marker.id),
                  infoWindow: InfoWindow(title: marker.name),
                  position: LatLng(marker.latitude, marker.longitude)))
            });
      });
    } catch (e) {
      // _showMessage
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        foregroundColor: Colors.black38,
        title: Text("구글 맵"),
        actions: [
          IconButton(
              onPressed: () {
                _showMarkerList();
              },
              icon: Icon(Icons.list)),
          IconButton(
              onPressed: () async {
                await StorageService().deleteMarkers();
                setState(() {
                  _markerSet = {};
                });
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      // 구글 맵 위젯 사용
      body: GoogleMap(
          onMapCreated: (controller) {
            // controller --> 새롭게 생성된 지도안에 생성한 GoogleController
            // 위에 변수로 선언을 해서 google controller를 주입
            _controller = controller;
          },
          markers: _markerSet,
          onLongPress: (argument) {
            _onMapTapped(argument);
          },
          initialCameraPosition: CameraPosition(target: _initCenter, zoom: 15)),
      bottomNavigationBar: Container(
        color: Colors.blue[200],
        padding: EdgeInsets.all(16),
        child: Text(
          "마커된 장소 ${_markerSet.length}개",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // 마커 목록 화면 표시 메서드
  void _showMarkerList() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("목록 화면은 다음 단계에서 구현할 예정")));
  }

  void _addMaker(LatLng positon, String name) {
    // 고유 ID 생성
    final markerId = DateTime.now().millisecond.toString();

    // 새로운 SavedMarker 객체 생성
    final newMarker = SavedMarker.fromMap(
      {
        'id': markerId,
        'name': name,
        'latitude': positon.latitude,
        'longitude': positon.longitude,
      },
    );

    setState(() {
      // 새롭게 생성한 객체를 마커 List 자료구조에 넣기
      _savedMarkers.add(newMarker);

      // 지도에 마커 추가
      _markerSet.add(
        Marker(
            markerId: MarkerId(markerId),
            position: positon,
            infoWindow: InfoWindow(
              title: name,
              snippet: '저장된 장소',
            )),
      );
    });
    // 로컬에 저장
    _saveMarkers();
  }

  Future<void> _saveMarkers() async {
    try {
      final success = await _storageService.saveMarkers(_savedMarkers);
      if (success) {
        _showMessage("저장 성공");
      } else {
        _showMessage("저장 실패");
      }
    } catch (e) {
      _showMessage("저장 오류");
    }
  }

  void _onMapTapped(LatLng position) {
    final nameController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("새 장소 추가"),
            content: SizedBox(
              height: 70,
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "장소 이름",
                      hintText: "예: 서울 시청",
                      border: OutlineInputBorder(),
                    ),
                    autofocus: true,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("취소")),
              TextButton(
                  onPressed: () {
                    _addMaker(position, "새 위치");
                    Navigator.pop(context);
                  },
                  child: Text("저장")),
            ],
          );
        });
  }
}
