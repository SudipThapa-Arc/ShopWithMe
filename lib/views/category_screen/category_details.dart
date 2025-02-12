import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/colors.dart';
import 'package:myapp/constants/common_lists.dart';
import 'package:myapp/constants/images.dart';
import 'package:myapp/constants/styles.dart';
import 'package:myapp/views/category_screen/item_details.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryDetails extends StatelessWidget {
  final String title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title.text.white.fontFamily(semibold).make(),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                children: [
                  ...List.generate(
                    categoryList.length,
                    (index) => categoryList[index]
                        .text
                        .size(12)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .makeCentered()
                        .box
                        .white
                        .rounded
                        .size(150, 40)
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .make(),
                  ),
                ],
              ),
            ),
            //items-showcase
            20.heightBox,
            Expanded(
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 6,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 200,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(imgP3, width: 120, height: 120),
                      5.heightBox,
                      "Laptop 16/256GB"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .size(14)
                          .maxLines(2)
                          .overflow(TextOverflow.ellipsis)
                          .make(),
                      5.heightBox,
                      "\$1200"
                          .text
                          .fontFamily(bold)
                          .color(redColor)
                          .size(16)
                          .make(),
                    ],
                  )
                      .box
                      .margin(const EdgeInsets.symmetric(horizontal: 4))
                      .padding(const EdgeInsets.all(12))
                      .white
                      .outerShadowSm
                      .roundedSM
                      .make()
                      .onTap(() {
                    Get.to(() => ItemDetails(title: "Laptop 16/256GB"));
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
