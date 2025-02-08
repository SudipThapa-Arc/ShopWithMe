import 'package:flutter/material.dart';
import 'package:myapp/consts/consts.dart';

Widget custombutton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
    onPressed: onPress,
    style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(12),
        backgroundColor: color,
        foregroundColor: textColor),
    child: title!.text.color(textColor).fontFamily(bold).make(),
  );
}
