import 'package:flutter/material.dart';
import 'package:myapp/consts/colors.dart';
import 'package:myapp/consts/consts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Container(
          color: lightGrey,
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: whiteColor,
              hintText: searchhint,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
