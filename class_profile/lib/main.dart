import 'package:class_profile/components/profile_drawer.dart';
import 'package:flutter/material.dart';
import 'components/profile_buttons.dart';
import 'components/profile_count_info.dart';
import 'components/profile_header.dart';
import 'components/profile_tab.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mTheme(),
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios),
          title: Text("Profile"),
          centerTitle: true,
        ),
        endDrawer: ProfileDrawer(),
        body: Column(
          children: [
            const SizedBox(height: 20),
            ProfileHeader(),
            const SizedBox(height: 20),
            ProfileCountInfo(),
            const SizedBox(height: 20),
            ProfileButtons(),
            const SizedBox(height: 20),
            Expanded(child: ProfileTab()),
          ],
        ),
      ),
    );
  }
}
