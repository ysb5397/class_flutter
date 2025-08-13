import 'package:class_login/size.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  const CustomTextFormField(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(height: small_gap),
        TextFormField(
          validator: (value) =>
              value!.isEmpty ? "Please Enter Some Text" : null,
          obscureText: text == "Password" ? true : false,
          decoration: InputDecoration(
              // html의 placeholder와 동일
              hintText: "Enter ${text}",
              // 기본 형태
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              // 눌렀을 때 보이는 형태
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              // 에러가 났을 때 보이는 형태
              errorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              // 에러가 난 뒤 다시 눌렀을 때 보이는 형태
              focusedErrorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        )
      ],
    );
  }
}
