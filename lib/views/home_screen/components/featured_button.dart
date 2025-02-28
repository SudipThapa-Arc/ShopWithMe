import 'package:flutter/material.dart';
import 'package:shopwithme/constants/consts.dart';

Widget featuredButton({String? title, image}) {
  return Row(
    children: [
      Image.asset(
        image!,
        width: 60,
        fit: BoxFit.fill,
      ),
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .outerShadowSm
      .width(200)
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .color(lightGrey)
      .padding(EdgeInsets.all(4))
      .roundedSM
      .make();
}
