import 'package:class_market/ch02/screens/chatting/chatting_screen.dart';
import 'package:class_market/ch02/screens/home/home_screen.dart';
import 'package:class_market/ch02/screens/my_carrot/my_carrot_screen.dart';
import 'package:class_market/ch02/screens/near_me/near_me_screen.dart';
import 'package:class_market/ch02/screens/neighborhood_life/neighborhood_life_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 한번에 모든 화면이 다 로딩된다
      // index 번호로 접근 및 조작 가능
      body: IndexedStack(
        children: [
          HomeScreen(),
          NeighborhoodLifeScreen(),
          NearMeScreen(),
          ChattingScreen(),
          MyCarrotScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        // BottomNavigatorItem이 표시가 안될 때 fixed로 설정
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          _selectedIndex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            label: "홈",
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            label: "동네 생활",
            icon: Icon(CupertinoIcons.square_arrow_down),
          ),
          BottomNavigationBarItem(
            label: "내 주변",
            icon: Icon(CupertinoIcons.placemark),
          ),
          BottomNavigationBarItem(
            label: "채팅",
            icon: Icon(CupertinoIcons.chat_bubble),
          ),
          BottomNavigationBarItem(
            label: "마이 페이지",
            icon: Icon(CupertinoIcons.gear),
          ),
        ],
      ),
    );
  }
}
