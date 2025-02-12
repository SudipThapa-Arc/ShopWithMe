import 'package:flutter/material.dart';
import 'package:myapp/constants/consts.dart';
import 'package:myapp/constants/common_lists.dart';

import '../../common_widgets/home_buttons.dart';
import 'components/featured_button.dart';

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
                    20.heightBox,
                    //featured categories
                    Align(
                      alignment: Alignment.center,
                      child: featuredcategories.text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .size(20)
                          .make(),
                    ),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...List.generate(
                              3,
                              (index) => Column(
                                    children: [
                                      featuredButton(
                                        image: featuredList[index],
                                        title: featuredTitles[index],
                                      ),
                                      featuredButton(
                                        image: featuredList2[index],
                                        title: featuredTitles2[index],
                                      )
                                    ],
                                  )),
                        ],
                      ),
                    ),

                    //featured products
                    20.heightBox,
                    Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProducts.text
                              .fontFamily(semibold)
                              .color(whiteColor)
                              .size(20)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                  2,
                                  (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(imgP1),
                                      10.heightBox,
                                      "Laptop 16/256GB"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "\$1200"
                                          .text
                                          .fontFamily(bold)
                                          .color(redColor)
                                          .size(16)
                                          .make(),
                                      10.heightBox,
                                    ],
                                  )
                                      .box
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .padding(const EdgeInsets.all(8))
                                      .white
                                      .roundedSM
                                      .make(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    20.heightBox,
                    VxSwiper.builder(
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          imgP1,
                          fit: BoxFit.fitWidth,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    20.heightBox,
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 300,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(imgP3, width: 150, height: 150),
                            Spacer(),
                            "Laptop 16/256GB"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            Spacer(),
                            "\$1200"
                                .text
                                .fontFamily(bold)
                                .color(redColor)
                                .size(16)
                                .make(),
                            Spacer(),
                          ],
                        )
                            .box
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .padding(const EdgeInsets.all(12))
                            .white
                            .roundedSM
                            .make();
                      },
                    )
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
