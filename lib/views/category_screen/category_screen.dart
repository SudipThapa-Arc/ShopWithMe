import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common_widgets/bgwidget.dart';
import 'package:myapp/constants/consts.dart';
import 'package:myapp/views/category_screen/category_details.dart';

import '../../constants/common_lists.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
          appBar: AppBar(
            title: categories.text.white.fontFamily(semibold).make(),
          ),
          body: Container(
            padding: EdgeInsets.all(12),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 200,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Image.asset(categoryListImages[index],
                        width: 200, height: 100, fit: BoxFit.cover),
                    categoryList[index].text.fontFamily(semibold).make(),
                    10.heightBox,
                    "${categoryList[index].length} items"
                        .text
                        .align(TextAlign.center)
                        .color(darkFontGrey)
                        .make(),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .clip(Clip.antiAlias)
                    .outerShadowSm
                    .padding(EdgeInsets.all(12))
                    .make()
                    .onTap(() {
                  Get.to(() => CategoryDetails(
                        title: categoryList[index],
                      ));
                });
              },
            ),
          )),
    );
  }
}
