import 'package:flutter/material.dart';
import 'package:shopwithme/constants/consts.dart';

Widget homeButton({
  String? title,
  icon,
  onPressed,
  width,
  height,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.rounded.white.size(width, height).make();
}
