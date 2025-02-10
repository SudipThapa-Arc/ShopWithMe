import 'package:flutter/material.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/consts/common_lists.dart';

import '../../common_widgets/home_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: lightGrey,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
          child: Column(children: [
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
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      autoPlayAnimationDuration: 4000.milliseconds,
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
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => homeButton(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 2.5,
                          title: index == 0 ? todaysdeal : flashsale,
                          icon: index == 0 ? icTodaysDeal : icFlashDeal,
                        ),
                      ),
                    ),
                    10.heightBox,
                    //2nd swiper
                    VxSwiper.builder(
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      autoPlayAnimationDuration: 6000.milliseconds,
                      itemCount: secondList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondList[index],
                          fit: BoxFit.fitWidth,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => homeButton(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 3.5,
                          icon: index == 0
                              ? icTopCategories
                              : index == 1
                                  ? icBrands
                                  : icTopSeller,
                          title: index == 0
                              ? topcategories
                              : index == 1
                                  ? topbrands
                                  : topSeller,
                        ),
                      ),
                    ),
                    10.heightBox,
                    //featured categories
                    Align(
                      alignment: Alignment.center,
                      child: featuredcategories.text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .size(20)
                          .make(),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
