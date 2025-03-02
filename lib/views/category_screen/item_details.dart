import 'package:flutter/material.dart';
import 'package:shopwithme/constants/colors.dart';
import 'package:shopwithme/constants/styles.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:shopwithme/controllers/product_controller.dart';

class ItemDetails extends StatelessWidget {
  final String title;
  const ItemDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    // Get current product details
    var product = controller.currentProduct.value;
    if (product == null) {
      // Handle the case when product is null
      return Scaffold(
        appBar: AppBar(
          title: "Product not found".text.make(),
        ),
        body: Center(
          child: "Product details not available".text.color(darkFontGrey).make(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: title.text.color(darkFontGrey).fontFamily(semibold).make(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: darkFontGrey,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
              color: darkFontGrey,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand logo or category name
                    Center(
                      child: controller.currentCategory.value.text
                          .size(18)
                          .color(darkFontGrey)
                          .fontFamily(bold)
                          .uppercase
                          .make(),
                    ),
                    10.heightBox,
                    
                    // Product title with rating
                    Row(
                      children: [
                        Expanded(
                          child: title.text
                              .size(20)
                              .color(darkFontGrey)
                              .fontFamily(bold)
                              .make(),
                        ),
                        VxRating(
                          onRatingUpdate: (value) {},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          count: 5,
                          size: 20,
                          stepInt: true,
                          value: product.rating ?? 4.5,
                        ),
                      ],
                    ),
                    
                    15.heightBox,
                    
                    // Product Images Slider
                    VxSwiper.builder(
                      autoPlay: true,
                      height: 300,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      itemCount: product.image.length,
                      itemBuilder: (context, index) {
                        String imageUrl = product.image.isNotEmpty
                            ? product.image[index]
                            : product.image;
                            
                        return imageUrl.startsWith('http')
                            ? Image.network(
                                imageUrl,
                                width: double.infinity,
                                fit: BoxFit.contain,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                          "assets/images/product.png",
                          width: double.infinity,
                                      fit: BoxFit.contain,
                                    ),
                              )
                            : Image.asset(
                                imageUrl,
                                width: double.infinity,
                                fit: BoxFit.contain,
                        );
                      },
                    ),
                    
                    20.heightBox,
                    
                    // Price with shipping info
                    Row(
                      children: [
                        "\$${product.price}"
                            .text
                            .color(redColor)
                            .fontFamily(bold)
                            .size(22)
                            .make(),
                        10.widthBox,
                        "*Including shipping"
                                  .text
                            .color(textfieldGrey)
                            .size(14)
                                  .make(),
                            ],
                          ),
                    
                    20.heightBox,
                    
                    // Color Selection
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Color".text.color(darkFontGrey).fontFamily(semibold).make(),
                        10.heightBox,
                        Obx(
                          () => Wrap(
                            spacing: 8,
                            children: List.generate(
                              product.colors.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  controller.setColorIndex(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: controller.colorIndex.value == index
                                          ? darkFontGrey
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: getColorFromString(
                                      product.colors.isNotEmpty
                                          ? product.colors[index]
                                          : index == 0
                                              ? "black"
                                              : index == 1
                                                  ? "red"
                                                  : index == 2
                                                      ? "blue"
                                                      : index == 3
                                                          ? "green"
                                                          : index == 4
                                                              ? "orange"
                                                              : "purple",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                              ),
                            ),
                          ],
                    ),
                    
                    20.heightBox,
                    
                    // Size Selection
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        "Size".text.color(darkFontGrey).fontFamily(semibold).make(),
                        10.heightBox,
                        Obx(
                          () => Wrap(
                            spacing: 8,
                            children: List.generate(
                              product.sizes?.length ?? 10,
                              (index) {
                                String size = product.sizes != null && product.sizes!.isNotEmpty
                                    ? product.sizes![index]
                                    : "${6 + (index * 0.5)} US";
                                    
                                return GestureDetector(
                                  onTap: () {
                                    controller.setSizeIndex(index);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: textfieldGrey),
                                      borderRadius: BorderRadius.circular(4),
                                      color: controller.sizeIndex.value == index
                                          ? darkFontGrey
                                          : Colors.white,
                                    ),
                                    child: size
                                    .text
                                        .color(controller.sizeIndex.value == index
                                            ? Colors.white
                                            : darkFontGrey)
                                        .fontFamily(semibold)
                                    .make(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    30.heightBox,
                    
                    // Description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,
                        (product.description)
                        .text
                        .color(darkFontGrey)
                        .make(),
                      ],
                    ),
                    
                    30.heightBox,
                    
                    // Products you may like
                    productsyoumaylike.text
                        .fontFamily(bold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    
                    // Related products
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          6,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/product.png",
                                width: 150,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              10.heightBox,
                              "Related Product ${index + 1}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "\$${99 + (index * 10)}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .padding(const EdgeInsets.all(8))
                              .make(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      controller.addToCart(product);
                      VxToast.show(context, msg: "${product.title} added to cart");
                    },
                    child: "Add to cart".text.black.fontFamily(semibold).make(),
                  ).box.margin(const EdgeInsets.only(left: 8, right: 4, bottom: 8)).make(),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    onPressed: () {
                      controller.buyNow(product);
                    },
                    child: "Buy now".text.black.fontFamily(semibold).make(),
                  ).box.margin(const EdgeInsets.only(left: 4, right: 8, bottom: 8)).make(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to convert string color names to Color objects
  Color getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      case 'pink':
        return Colors.pink;
      case 'teal':
        return Colors.teal;
      case 'brown':
        return Colors.brown;
      case 'grey':
      case 'gray':
        return Colors.grey;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      default:
        return Colors.black;
    }
  }
}

const itemDetailButtonsList = [
  "Video",
  "Reviews",
  "Seller Policy",
  "Return Policy",
  "Support Policy"
];

const productsyoumaylike = "Products you may also like";

