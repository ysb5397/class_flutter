import 'package:flutter/material.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [_buildFollowButton(), _buildMessageButton()],
    );
  }

  Widget _buildFollowButton() {
    return InkWell(
      onTap: () {
        print("Follow 버튼 클릭됨");
      },
      child: Container(
        alignment: Alignment.center,
        width: 150,
        height: 45,
        child: Text(
          "Follow",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius:
                BorderRadius.circular(10)), // 아예 color 속성과 동시에 쓸 수가 없음
      ),
    );
  }

  Widget _buildMessageButton() {
    return InkWell(
      onTap: () {
        print("Message 버튼 클릭 됨");
      },
      child: Container(
        alignment: Alignment.center,
        width: 150,
        height: 45,
        child: Text(
          "Message",
          style: TextStyle(fontSize: 20),
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius:
                BorderRadius.circular(10)), // 아예 color 속성과 동시에 쓸 수가 없음
      ),
    );
  }
}
