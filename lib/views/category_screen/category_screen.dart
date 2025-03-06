import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/constants/consts.dart';
import 'package:shopwithme/design_system/borders.dart';
import 'package:shopwithme/views/category_screen/category_details.dart';
import 'package:shopwithme/controllers/product_controller.dart';
import '../../constants/common_lists.dart';
import 'dart:math';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/inputs.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  
  const CategoryScreen({
    Key? key, 
    required this.category,
  }) : super(key: key);

  Widget _buildFeaturedCategoryCard(BuildContext context, String category, int index, ProductController controller) {
    final colors = [
      AppColors.primary.withOpacity(0.1),
      AppColors.info.withOpacity(0.1),
      AppColors.success.withOpacity(0.1),
      AppColors.warning.withOpacity(0.1),
    ];
    
    final iconColors = [
      AppColors.primary,
      AppColors.info,
      AppColors.success,
      AppColors.warning,
    ];

    final icons = [
      Icons.shopping_bag,
      Icons.person,
      Icons.child_care,
      Icons.devices,
    ];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          controller.setCurrentCategory(category);
          Get.to(
            () => CategoryDetails(title: category),
            transition: Transition.fadeIn,
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 160,
          margin: EdgeInsets.only(right: Spacing.md),
          decoration: BoxDecoration(
            color: colors[index % colors.length],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: iconColors[index % iconColors.length].withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -10,
                bottom: -10,
                child: Icon(
                  icons[index % icons.length],
                  size: 80,
                  color: iconColors[index % iconColors.length].withOpacity(0.1),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icons[index % icons.length],
                      size: 32,
                      color: iconColors[index % iconColors.length],
                    ),
                    SizedBox(height: Spacing.sm),
                    Text(
                      category,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: Spacing.xs),
                    Text(
                      '${controller.categoryProducts[category]?.length ?? 0} Products',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryGridItem(BuildContext context, String category, String image, int index, ProductController controller) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          controller.setCurrentCategory(category);
          Get.to(
            () => CategoryDetails(title: category),
            transition: Transition.fadeIn,
          );
        },
        borderRadius: BorderRadius.circular(AppBorders.radiusMd),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppBorders.radiusMd),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
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
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppBorders.radiusMd),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(Spacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        category,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Spacing.xs),
                      Row(
                        children: [
                          Text(
                            '${controller.categoryProducts[category]?.length ?? 0} Products',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    final Size screenSize = MediaQuery.of(context).size;
    
    // Adaptive values based on screen width
    final bool isLargeScreen = screenSize.width > 1200;
    final bool isMediumScreen = screenSize.width > 800 && screenSize.width <= 1200;
    final double maxContentWidth = isLargeScreen ? 1200 : screenSize.width;
    final int gridCrossAxisCount = isLargeScreen ? 4 : isMediumScreen ? 3 : 2;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center( // Center the content on large screens
          child: SizedBox(
            width: maxContentWidth,
            child: CustomScrollView(
              slivers: [
                // Custom App Bar with Search
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(Spacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categories',
                          style: AppTypography.headlineLarge,
                        ),
                        SizedBox(height: Spacing.xs),
                        Text(
                          'Find everything you need',
                          style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: Spacing.md),
                        // Search Bar
                        AppInput(
                          hint: 'Search categories',
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.tune,
                          onSuffixIconPressed: () {
                            // Handle filter
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Featured Categories Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(Spacing.md),
                    child: Row(
                      children: [
                        Text(
                      'Featured Categories',
                          style: AppTypography.headlineMedium,
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            // Scroll to all categories section
                          },
                          child: Row(
                            children: [
                              Text(
                                'See All',
                                style: AppTypography.labelLarge.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Featured Categories List
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: Spacing.md),
                      physics: const BouncingScrollPhysics(),
                      itemCount: 4, // Show first 4 categories
                      itemBuilder: (context, index) {
                        return _buildFeaturedCategoryCard(
                          context,
                                categoryList[index],
                          index,
                          controller,
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
                  padding: EdgeInsets.all(Spacing.md),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildCategoryGridItem(
                          context,
                                          categoryList[index],
                          categoryImages[index],
                          index,
                          controller,
                        );
                      },
                      childCount: 8,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridCrossAxisCount,
                      mainAxisSpacing: Spacing.md,
                      crossAxisSpacing: Spacing.md,
                      childAspectRatio: 0.8,
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
