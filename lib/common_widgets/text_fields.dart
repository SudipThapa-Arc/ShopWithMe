import 'package:flutter/material.dart';
import 'package:shopwithme/constants/consts.dart';

Widget customtextfield({
  String? title,
  String? hint,
  TextEditingController? controller,
  required bool isPass,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.fontFamily(semibold).size(16).color(redColor).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        obscureText: isPass,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontFamily: semibold, color: fontGrey),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: redColor)
          ),
        ),
      ),
    ],
  );
}
