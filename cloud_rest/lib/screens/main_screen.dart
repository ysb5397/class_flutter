import 'package:cloud_rest/components/recruit_list.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("클라우드 모바일"),
        actions: [],
        backgroundColor: Colors.blue[100],
      ),
      body: RecruitList(),
    );
  }
}
