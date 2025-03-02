import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/constants/consts.dart';
import 'package:shopwithme/views/category_screen/category_details.dart';
import 'package:shopwithme/controllers/product_controller.dart';
import '../../constants/common_lists.dart';
import 'dart:math';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    final Size screenSize = MediaQuery.of(context).size;
    final searchController = TextEditingController();
    
    // Adaptive values based on screen width
    final bool isLargeScreen = screenSize.width > 1200;
    final bool isMediumScreen = screenSize.width > 800 && screenSize.width <= 1200;
    final double maxContentWidth = isLargeScreen ? 1200 : screenSize.width;
    final int gridCrossAxisCount = isLargeScreen ? 4 : isMediumScreen ? 3 : 2;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center( // Center the content on large screens
          child: SizedBox(
            width: maxContentWidth,
            child: CustomScrollView(
              slivers: [
                // Custom App Bar with Search
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(screenSize.width * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: min(screenSize.width * 0.05, 40),
                            fontFamily: bold,
                            color: darkFontGrey,
                          ),
                        ),
                        SizedBox(height: min(screenSize.width * 0.01, 10)),
                        Text(
                          'Find everything you need',
                          style: TextStyle(
                            fontSize: min(screenSize.width * 0.03, 20),
                            color: darkFontGrey.withAlpha(178), // 0.7 opacity
                          ),
                        ),
                        SizedBox(height: min(screenSize.width * 0.02, 20)),
                        // Search Bar
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withAlpha(25), // 0.1 opacity
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'Search categories',
                                prefixIcon: const Icon(Icons.search, color: darkFontGrey),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.tune, color: darkFontGrey),
                                  onPressed: () {},
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Featured Categories
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(min(screenSize.width * 0.02, 20)),
                    child: Text(
                      'Featured Categories',
                      style: TextStyle(
                        fontSize: min(screenSize.width * 0.03, 24),
                        fontFamily: bold,
                        color: darkFontGrey,
                      ),
                    ),
                  ),
                ),

                // Horizontal Scrolling Featured Categories
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: min(screenSize.height * 0.15, 120),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: min(screenSize.width * 0.02, 20),
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          width: min(screenSize.width * 0.3, 200),
                          margin: EdgeInsets.only(
                            right: min(screenSize.width * 0.02, 20),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.primaries[index % Colors.primaries.length]
                                .withAlpha(51), // 0.2 opacity
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.category,
                                size: min(screenSize.width * 0.06, 40),
                                color: Colors.primaries[index % Colors.primaries.length],
                              ),
                              SizedBox(height: min(screenSize.height * 0.01, 8)),
                              Text(
                                categoryList[index],
                                style: TextStyle(
                                  fontSize: min(screenSize.width * 0.025, 16),
                                  fontFamily: semibold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // All Categories Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(min(screenSize.width * 0.02, 20)),
                    child: Text(
                      'All Categories',
                      style: TextStyle(
                        fontSize: min(screenSize.width * 0.03, 24),
                        fontFamily: bold,
                        color: darkFontGrey,
                      ),
                    ),
                  ),
                ),

                // Categories Grid
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: min(screenSize.width * 0.02, 20),
                  ),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridCrossAxisCount,
                      mainAxisSpacing: min(screenSize.width * 0.02, 20),
                      crossAxisSpacing: min(screenSize.width * 0.02, 20),
                      childAspectRatio: 0.85,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => CategoryDetails(title: categoryList[index]),
                              transition: Transition.fadeIn,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withAlpha(25), // 0.1 opacity
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(15),
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage(categoryListImages[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          categoryList[index],
                                          style: TextStyle(
                                            fontSize: min(screenSize.width * 0.025, 18),
                                            fontFamily: bold,
                                            color: darkFontGrey,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${controller.categoryProducts[categoryList[index]]?.length ?? 0} Products',
                                          style: TextStyle(
                                            fontSize: min(screenSize.width * 0.02, 14),
                                            color: darkFontGrey.withAlpha(178), // 0.7 opacity
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
                      },
                      childCount: 8,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(bottom: min(screenSize.width * 0.02, 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
