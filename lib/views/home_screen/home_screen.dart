import 'package:flutter/material.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/consts/social_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.search,
                    color: textfieldGrey,
                  ),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchhint,
                  hintStyle: const TextStyle(
                    color: textfieldGrey,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            //swiper
            VxSwiper.builder(
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlay: true,
              height: 150,
              autoPlayAnimationDuration: 3000.milliseconds,
              itemCount: brandList.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  brandList[index],
                  fit: BoxFit.fitWidth,
                )
                    .box
                    .rounded
                    .clip(Clip.antiAlias)
                    .margin(const EdgeInsets.symmetric(horizontal: 8))
                    .make();
              },
            ),
          ],
        ),
      ),
    );
  }
}
