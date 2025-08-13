import 'package:class_login/components/custom_text_form_field.dart';
import 'package:class_login/size.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // 글로벌 키 -> form태그 식별자
  CustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // key 라는 속성에 연결 --> key로 form 태그의 상태를 관리 가능
      child: Column(
        children: [
          CustomTextFormField("Email"),
          SizedBox(height: medium_gap),
          CustomTextFormField("Password"),
          SizedBox(height: large_gap),
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // 비동기 방식으로 통신 요청 --> 응답 --> 화면 이동
                  // 앱의 화면을 전환 시키는 코드
                  Navigator.pushNamed(context, "/home");
                }
              },
              child: Text("Login"))
        ],
      ),
    );
  }
}
