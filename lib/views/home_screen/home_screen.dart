import 'package:flutter/material.dart';
import 'package:myapp/constants/consts.dart';
import 'package:myapp/constants/common_lists.dart';


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
            // Search Bar with improved design
            Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: textfieldGrey),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.filter_list, color: whiteColor),
                  ),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchhint,
                  hintStyle: const TextStyle(color: textfieldGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Main Banner Slider
                    VxSwiper.builder(
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 180,
                      itemCount: brandList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          brandList[index],
                          fit: BoxFit.cover,
                        ).box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),

                    20.heightBox,
                    
                    // Categories Section
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Categories".text.size(20).bold.make(),
                          10.heightBox,
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return Column(
                                    children: [
                                  Image.asset(
                                    categoryImages[index],
                                    height: 50,
                                    width: 50,
                                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                                  5.heightBox,
                                  categoryNames[index].text.size(12).make(),
                                ],
                              ).box
                                  .white
                                  .rounded
                                  .padding(const EdgeInsets.all(8))
                                  .make();
                            },
                          ),
                        ],
                      ),
                    ),

                    20.heightBox,

                    // Featured Products Section
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          featuredProducts.text
                              .size(20)
                                  .bold
                                  .color(darkFontGrey)
                              .make(),
                              "View All"
                                  .text
                                  .color(redColor)
                                  .make()
                                  .onTap(() {
                                    // Handle view all
                                  }),
                            ],
                          ),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                6,
                                (index) => Container(
                                  width: 150,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgP1,
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ).box.rounded.clip(Clip.antiAlias).make(),
                                      10.heightBox,
                                      "Laptop 16/256GB"
                                          .text
                                          .semiBold
                                          .size(14)
                                          .color(darkFontGrey)
                                          .make(),
                                      5.heightBox,
                                      "\$1200"
                                          .text
                                          .bold
                                          .color(redColor)
                                          .size(16)
                                          .make(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    20.heightBox,

                    // Flash Sale Section
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Flash Sale"
                                  .text
                                  .white
                                  .bold
                                  .size(20)
                                  .make(),
                              Row(
                                children: [
                                  "Ends in: ".text.white.make(),
                                  "02:45:30"
                                      .text
                                      .white
                                      .bold
                                      .make(),
                                ],
                              ),
                            ],
                          ),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                6,
                                (index) => Container(
                                  width: 150,
                                  margin: const EdgeInsets.only(right: 10),
                                  color: whiteColor,
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgP3,
                      height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "Product Name"
                                          .text
                                          .semiBold
                                          .make(),
                                      5.heightBox,
                                      Row(
                                        children: [
                                          "\$999"
                                              .text
                                              .bold
                                              .color(redColor)
                                              .size(16)
                                              .make(),
                                          10.widthBox,
                                          "\$1299"
                                              .text
                                              .lineThrough
                                              .gray500
                                              .make(),
                                        ],
                                      ),
                                      "Save 23%"
                                          .text
                                          .white
                                          .semiBold
                                          .make()
                                          .box
                                          .color(redColor)
                                          .padding(const EdgeInsets.symmetric(horizontal: 8, vertical: 4))
                                          .roundedSM
                                          .make(),
                                    ],
                                  ),
                                ).box.rounded.clip(Clip.antiAlias).make(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    20.heightBox,

                    // Grid Products
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Popular Products"
                              .text
                              .size(20)
                              .bold
                              .make(),
                          10.heightBox,
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                              mainAxisExtent: 250,
                      ),
                            itemCount: 4,
                      itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                    Image.asset(
                                      imgP3,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ).box.rounded.clip(Clip.antiAlias).make(),
                                    10.heightBox,
                                    "Product Name".text.semiBold.make(),
                                    5.heightBox,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        "\$1200".text.bold.color(redColor).size(16).make(),
                                        const Icon(
                                          Icons.favorite_border,
                                          color: darkFontGrey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
