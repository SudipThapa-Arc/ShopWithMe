import 'package:flutter/material.dart';
import 'package:myapp/constants/colors.dart';
import 'package:myapp/constants/styles.dart';
import 'dart:math';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isLargeScreen = screenSize.width > 1200;
    // ignore: unused_local_variable
    final bool isMediumScreen = screenSize.width > 800 && screenSize.width <= 1200;
    final double maxContentWidth = isLargeScreen ? 1200 : screenSize.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        elevation: 0.5,
        title: Text(
          "My Cart (2 Items)",
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: bold,
            fontSize: min(screenSize.width * 0.045, 22),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: maxContentWidth,
            child: Column(
              children: [
                // Cart Items List
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(min(screenSize.width * 0.02, 16)),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: min(screenSize.width * 0.02, 16)),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(min(screenSize.width * 0.02, 16)),
                          child: Row(
                            children: [
                              // Product Image
                              Container(
                                height: min(screenSize.width * 0.25, 120),
                                width: min(screenSize.width * 0.25, 120),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                   image: NetworkImage('https://imgs.search.brave.com/RGvOdrwnHWTnbl--AYiBsJiv2zkwKaJtZMZ0W5cJkIk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pdnlj/aXR5Y28uY29tL2Nk/bi9zaG9wL2ZpbGVz/L3dlYi1sb3ZlcnMz/LTA0LmpwZz92PTE3/Mzg1NTU0MDgmd2lk/dGg9MTAwMA'),
                                    fit: BoxFit.cover,
                                  ),
                                  
                                ),
                              ),
                              SizedBox(width: min(screenSize.width * 0.03, 20)),
                              
                              // Product Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      index == 0 ? "Floral Dress Pink" : "Macho Tshirt",
                                      style: TextStyle(
                                        fontSize: min(screenSize.width * 0.035, 18),
                                        fontFamily: bold,
                                        color: darkFontGrey,
                                      ),
                                    ),
                                    SizedBox(height: min(screenSize.width * 0.02, 10)),
                                    Text(
                                      "Weight: ${index == 0 ? "2kg" : "1kg"}",
                                      style: TextStyle(
                                        fontSize: min(screenSize.width * 0.03, 14),
                                        color: darkFontGrey.withOpacity(0.7),
                                        fontFamily: semibold,
                                      ),
                                    ),
                                    SizedBox(height: min(screenSize.width * 0.02, 10)),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${index == 0 ? "72" : "45"}",
                                          style: TextStyle(
                                            fontSize: min(screenSize.width * 0.04, 20),
                                            fontFamily: bold,
                                            color: redColor,
                                          ),
                                        ),
                                        SizedBox(width: min(screenSize.width * 0.02, 16)),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Colors.grey[300]!,
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.remove,
                                                  size: min(screenSize.width * 0.04, 20),
                                                  color: darkFontGrey,
                                                ),
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                                child: Text(
                                                  "1",
                                                  style: TextStyle(
                                                    fontSize: min(screenSize.width * 0.035, 16),
                                                    fontFamily: bold,
                                                    color: darkFontGrey,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.add,
                                                  size: min(screenSize.width * 0.04, 20),
                                                  color: darkFontGrey,
                                                ),
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
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
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: redColor.withOpacity(0.9),
                                  size: min(screenSize.width * 0.05, 24),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Checkout Section
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(min(screenSize.width * 0.04, 20)),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[200]!,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildPriceText("Total:", darkFontGrey.withOpacity(0.7), screenSize),
                                  buildPriceText("VAT:", darkFontGrey.withOpacity(0.7), screenSize),
                                  buildPriceText("Delivery fee:", darkFontGrey.withOpacity(0.7), screenSize),
                                  SizedBox(height: min(screenSize.width * 0.02, 10)),
                                  buildPriceText("Sub Total:", darkFontGrey, screenSize, isBold: true),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  buildPriceText("\$192", darkFontGrey, screenSize),
                                  buildPriceText("\$5", darkFontGrey, screenSize),
                                  buildPriceText("Free", redColor, screenSize),
                                  SizedBox(height: min(screenSize.width * 0.02, 10)),
                                  buildPriceText("\$197", darkFontGrey, screenSize, isBold: true),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Checkout Button
                        SizedBox(
                          width: double.infinity,
                          height: min(screenSize.height * 0.08, 60),
                          child: Material(
                            color: Colors.green[600],
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Text(
                                  "Check Out",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: min(screenSize.width * 0.04, 18),
                                    fontFamily: bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPriceText(String text, Color color, Size screenSize, {bool isBold = false}) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: min(screenSize.width * 0.035, isBold ? 18 : 16),
        fontFamily: isBold ? bold : semibold,
        height: 1.5,
      ),
    );
  }
}
