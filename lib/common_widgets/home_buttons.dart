import 'package:flutter/material.dart';
import 'package:myapp/consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../consts/styles.dart';

Widget homeButton({String? title, String? image, String? onPressed}) {
  return Expanded(
    child: Column(
      children: [
        Image.asset(
          image!,
          width: 26,
          height: 26,
        ),
        title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      ],
    ),
  ).box.color(lightGrey).rounded.padding(const EdgeInsets.all(4)).make();
}
