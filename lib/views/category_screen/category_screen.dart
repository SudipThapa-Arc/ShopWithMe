import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/consts.dart';
import 'package:myapp/views/category_screen/category_details.dart';
import 'package:myapp/controllers/product_controller.dart';

import '../../constants/common_lists.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: redColor,
        title: categories.text.white.fontFamily(bold).size(22).make(),
        actions: [
          IconButton(
            onPressed: () {
              // Add search functionality
            },
            icon: const Icon(Icons.search, color: whiteColor),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Featured Categories Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Featured Categories"
                      .text
                      .size(18)
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .make(),
                  "View All"
                      .text
                      .color(redColor)
                      .fontFamily(semibold)
                      .make()
                      .onTap(() {
                    // Handle view all
                  }),
                ],
              ),
            ),

            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 250,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Image
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            image: DecorationImage(
                              image: AssetImage(categoryListImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // Category Details
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Category Name
                              categoryList[index]
                                  .text
                                  .size(16)
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              8.heightBox,

                              // Items Count
                              Row(
                                children: [
                                  "${controller.categoryProducts[categoryList[index]]?.length ?? 0}"
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make(),
                                  5.widthBox,
                                  "items"
                                      .text
                                      .color(darkFontGrey)
                                      .make(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).onTap(() {
                    Get.to(
                      () => CategoryDetails(title: categoryList[index]),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 300),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
