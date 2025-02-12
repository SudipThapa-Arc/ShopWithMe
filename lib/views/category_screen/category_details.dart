import 'package:flutter/material.dart';
import 'package:myapp/constants/colors.dart';
import 'package:myapp/constants/common_lists.dart';
import 'package:myapp/constants/styles.dart';
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
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.red,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
