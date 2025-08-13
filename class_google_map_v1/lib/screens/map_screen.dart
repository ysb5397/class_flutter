import 'dart:collection';

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
  static const LatLng _newCenter = LatLng(37.566295, 126.977945);
  final Set<Marker> _markers = {};
  int _makerCount = 0;

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
              icon: Icon(Icons.list))
        ],
      ),
      // 구글 맵 위젯 사용
      body: GoogleMap(
          onMapCreated: (controller) {
            // controller --> 새롭게 생성된 지도안에 생성한 GoogleController
            // 위에 변수로 선언을 해서 google controller를 주입
            _controller = controller;
          },
          markers: _markers,
          onLongPress: (argument) {
            _markers.add(Marker(
                markerId: MarkerId("a"),
                position: argument,
                infoWindow: const InfoWindow(title: "good")));
            _makerCount = _markers.length;
            setState(() {});
          },
          initialCameraPosition: CameraPosition(target: _initCenter, zoom: 15)),
      bottomNavigationBar: Container(
        color: Colors.blue[200],
        padding: EdgeInsets.all(16),
        child: Text(
          "마커된 장소 $_makerCount개",
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
}
