// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/colors.dart';
import 'package:myapp/constants/common_lists.dart';
import 'package:myapp/constants/styles.dart';
import 'package:myapp/views/category_screen/item_details.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:myapp/controllers/product_controller.dart';

class CategoryDetails extends StatelessWidget {
  final String title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    controller.setCurrentCategory(title);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Get.back();
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: redColor,
          title: title.text.white.fontFamily(semibold).make(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share, color: whiteColor),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline, color: whiteColor),
            ),
          ],
        ),
        body: Column(
          children: [
            20.heightBox,
            // Search bar
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: lightGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: lightGrey,
                  hintText: "Search in Category",
                  hintStyle: TextStyle(color: darkFontGrey),
                ),
              ),
            ),
            15.heightBox,

            // Categories list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    categoryList.length,
                    (index) => GestureDetector(
                      onTap: () {
                        controller.setCurrentCategory(categoryList[index]);
                        Get.off(
                          () => CategoryDetails(
                            title: categoryList[index],
                          ),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: controller.currentCategory.value ==
                                    categoryList[index]
                                ? redColor
                                : lightGrey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: categoryList[index]
                                .text
                                .size(12)
                                .color(
                                  controller.currentCategory.value ==
                                          categoryList[index]
                                      ? whiteColor
                                      : darkFontGrey,
                                )
                                .fontFamily(semibold)
                                .make(),
                          ),
                        ).box.height(40).make(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            20.heightBox,

            // Products grid
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Obx(
                  () {
                    var products = controller.getCurrentCategoryProducts();
                    return products.isEmpty
                        ? Center(
                            child: "No products found"
                                .text
                                .color(darkFontGrey)
                                .make(),
                          )
                        : GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 250,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                            ),
                            itemBuilder: (context, index) {
                              var product = products[index];
                              return GestureDetector(
                                onTap: () {
                                  controller.setCurrentProduct(
                                    title: product.title,
                                    price: product.price,
                                  );
                                  Get.to(
                                    () => ItemDetails(
                                      title: product.title,
                                    ),
                                    transition: Transition.rightToLeft,
                                    duration: const Duration(milliseconds: 300),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Stack(
                                          children: [
                                            product.image.startsWith('http')
                                                ? Image.network(
                                                    product.image,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      );
                                                    },
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        const Icon(Icons.error),
                                                  )
                                                : Image.asset(
                                                    product.image,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                            Positioned(
                                              right: 0,
                                              child: IconButton(
                                                icon: const Icon(
                                                    Icons.favorite_border),
                                                onPressed: () {
                                                  controller
                                                      .toggleFavorite(index);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      5.heightBox,
                                      product.title.text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .size(14)
                                          .make(),
                                      5.heightBox,
                                      Expanded(
                                        child: Obx(
                                          () => Row(
                                            children: List.generate(
                                              3,
                                              (i) => Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  VxBox()
                                                      .size(25, 25)
                                                      .roundedFull
                                                      .color(i == 0
                                                          ? Colors.red
                                                          : i == 1
                                                              ? Colors.blue
                                                              : Colors.green)
                                                      .margin(const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2))
                                                      .make()
                                                      .onTap(() {
                                                    controller.setColorIndex(i);
                                                  }),
                                                  Visibility(
                                                    visible: controller
                                                            .colorIndex.value ==
                                                        i,
                                                    child: const Icon(
                                                        Icons.done,
                                                        color: whiteColor,
                                                        size: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      "\$${product.price}"
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .size(16)
                                          .make(),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: redColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: whiteColor,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
