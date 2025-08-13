import 'package:class_airbnb/constants.dart';
import 'package:class_airbnb/styles.dart';
import 'package:flutter/material.dart';
import 'package:class_airbnb/size.dart';

class HomeHeaderAppbar extends StatelessWidget {
  const HomeHeaderAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(gap_m),
      child: Row(
        children: [
          _buildAppBarLogo(),
          Spacer(),
          _buildAppBarMenu(),
        ],
      ),
    );
  }

  Widget _buildAppBarLogo() {
    return Row(
      children: [
        Image.asset("assets/logo.png",
            width: 30, height: 30, color: kAccentColor),
        SizedBox(width: gap_s),
        Text("RoomOfAll", style: h5(mColor: Colors.white)),
      ],
    );
  }

  Widget _buildAppBarMenu() {
    return Row(
      children: [
        Text("회원가입", style: subTitle1(mColor: Colors.white)),
        SizedBox(width: gap_m),
        Text("로그인", style: subTitle1(mColor: Colors.white)),
      ],
    );
  }
}
