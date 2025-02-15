import 'package:flutter/material.dart';
import 'package:myapp/constants/colors.dart';
import 'package:myapp/constants/styles.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "My Cart (2 Items)"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      // Product Image
                      Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          "assets/images/product.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Name
                            (index == 0 ? "Mango Fruit" : "Orange Fruit")
                                .text
                                .size(16)
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            // Weight
                            "Weight: ${index == 0 ? "2kg" : "1kg"}"
                                .text
                                .color(textfieldGrey)
                                .make(),
                            10.heightBox,
                            // Price & Quantity Controls
                            Row(
                              children: [
                                "\$${index == 0 ? "72" : "45"}"
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make(),
                                10.widthBox,
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon:
                                            const Icon(Icons.remove, size: 16),
                                      ),
                                      "1"
                                          .text
                                          .size(16)
                                          .color(darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.add, size: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Delete Button
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: redColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Checkout Section
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              children: [
                // Subtotal Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Total:".text.color(textfieldGrey).make(),
                          "VAT:".text.color(textfieldGrey).make(),
                          "Delivery fee:".text.color(textfieldGrey).make(),
                          10.heightBox,
                          "Sub Total:"
                              .text
                              .color(darkFontGrey)
                              .size(16)
                              .fontFamily(semibold)
                              .make(),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          "\$192".text.color(darkFontGrey).make(),
                          "\$5".text.color(darkFontGrey).make(),
                          "Free".text.color(redColor).make(),
                          10.heightBox,
                          "\$197"
                              .text
                              .color(darkFontGrey)
                              .size(16)
                              .fontFamily(semibold)
                              .make(),
                        ],
                      ),
                    ],
                  ),
                ),
                // Checkout Button
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Vx.green500,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {},
                    child: "Check Out"
                        .text
                        .white
                        .size(16)
                        .fontFamily(semibold)
                        .make(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
