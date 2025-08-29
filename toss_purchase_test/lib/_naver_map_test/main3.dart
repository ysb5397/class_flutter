import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:location/location.dart';

void main() async {
  // main 함수는 그대로 둬도 좋아! 아주 잘 짰어.
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterNaverMap().init(
      clientId: '', // 실제 앱에서는 보안에 유의해야 해!
      onAuthFailed: (ex) {
        print("인증 실패: $ex");
      });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 앱의 기본 구조를 잡아주는 MaterialApp을 사용하는 게 더 좋아.
    return const MaterialApp(
      home: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // 위치 정보를 가져오는 로직을 Future로 만들어 둘 거야.
  // FutureBuilder가 이 Future의 상태를 감시할 거야.
  late final Future<LocationData?> _locationFuture;

  @override
  void initState() {
    super.initState();
    _locationFuture = _initPosition(); // initState에서 Future를 한 번만 실행!
  }

  // 위치 정보를 가져오는 전체 과정을 하나의 Future 함수로 묶었어.
  Future<LocationData?> _initPosition() async {
    final location = Location();
    try {
      var serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return null; // 서비스가 거부되면 null 반환
        }
      }

      var permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return null; // 권한이 거부되면 null 반환
        }
      }

      // 모든 권한이 허용되면 현재 위치를 가져와서 반환!
      return await location.getLocation();
    } catch (e) {
      print("위치 정보를 가져오는 데 실패했습니다: $e");
      return null; // 에러가 발생해도 null 반환
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // FutureBuilder를 사용해서 _locationFuture의 상태를 지켜보자!
      body: FutureBuilder<LocationData?>(
        future: _locationFuture,
        // snapshot에는 Future의 상태와 데이터가 들어있어.
        builder: (context, snapshot) {
          // 1. 로딩 중일 때 (아직 데이터가 없을 때)
          if (!snapshot.hasData) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("현재 위치를 가져오는 중..."),
                ],
              ),
            );
          }

          // 2. 데이터가 있지만 null일 때 (권한 거부 등)
          if (snapshot.data == null) {
            return const Center(
              child: Text("위치 권한을 허용해주세요."),
            );
          }

          // 3. 성공적으로 위치 정보를 가져왔을 때!
          final locationData = snapshot.data!;
          print("${locationData.latitude} / ${locationData.longitude}");
          final currentPosition =
              NLatLng(locationData.latitude!, locationData.longitude!);

          return NaverMap(
            options: NaverMapViewOptions(
              initialCameraPosition:
                  NCameraPosition(target: currentPosition, zoom: 15),
            ),
            onMapReady: (controller) {
              final marker = NMarker(
                id: "my_location",
                position: currentPosition,
                caption: const NOverlayCaption(text: "내 위치"),
              );
              controller.addOverlay(marker);
              print("네이버 맵 준비 완료! 현재 위치에 마커 표시!");
            },
          );
        },
      ),
    );
  }
}
