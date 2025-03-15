import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/constants/consts.dart';
import 'package:shopwithme/constants/common_lists.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/inputs.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/borders.dart';
import 'package:shopwithme/design_system/elevation.dart';
import 'package:shopwithme/common_widgets/product_card.dart';
import 'package:shopwithme/common_widgets/shimmer_loading.dart';
import 'package:shopwithme/common_widgets/product_grid_shimmer.dart';
import 'package:shopwithme/controllers/product_controller.dart';
import 'package:shopwithme/views/category_screen/product_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Responsive breakpoints
  static const double _tabletBreakpoint = 768;
  static const double _desktopBreakpoint = 1024;

  // Responsive helpers
  bool _isMobile(double width) => width < _tabletBreakpoint;
  bool _isTablet(double width) => width >= _tabletBreakpoint && width < _desktopBreakpoint;
  bool _isDesktop(double width) => width >= _desktopBreakpoint;

  // Get number of grid columns based on screen width
  int _getGridColumns(double width) {
    if (_isDesktop(width)) return 4;
    if (_isTablet(width)) return 3;
    return 2;
  }

  // Get category grid columns based on screen width
  int _getCategoryColumns(double width) {
    if (_isDesktop(width)) return 8;
    if (_isTablet(width)) return 6;
    return 4;
  }

  // Get product card width based on screen width
  double _getProductCardWidth(double width) {
    if (_isDesktop(width)) return 220;
    if (_isTablet(width)) return 200;
    return 180;
  }

  // Get banner aspect ratio based on screen width
  double _getBannerAspectRatio(double width) {
    if (_isDesktop(width)) return 21 / 9;
    if (_isTablet(width)) return 16 / 9;
    return 4 / 3;
  }

  // Get max content width based on screen width
  double _getMaxContentWidth(double width) {
    if (_isDesktop(width)) return 1200;
    if (_isTablet(width)) return 768;
    return width;
  }

  // Get product name max lines based on screen width
  int _getProductNameMaxLines(double width) {
    if (_isDesktop(width)) return 2;
    if (_isTablet(width)) return 2;
    return 1;
  }

  // Get product card height based on screen width
  double _getProductCardHeight(double width) {
    if (_isDesktop(width)) return 320;
    if (_isTablet(width)) return 300;
    return 260;
  }

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final screenWidth = MediaQuery.of(context).size.width;
    final productCardWidth = _getProductCardWidth(screenWidth);
    final productCardHeight = _getProductCardHeight(screenWidth);
    final productNameMaxLines = _getProductNameMaxLines(screenWidth);
    final bannerAspectRatio = _getBannerAspectRatio(screenWidth);
    final gridColumns = _getGridColumns(screenWidth);
    final categoryColumns = _getCategoryColumns(screenWidth);
    final horizontalPadding = _isMobile(screenWidth) ? Spacing.md : Spacing.lg;
    final maxContentWidth = _getMaxContentWidth(screenWidth);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: Column(
              children: [
                // Search Bar with improved design
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: Spacing.md,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: AppInput(
                      hint: searchhint,
                      prefixIcon: Icons.search,
                      suffixIcon: Icons.filter_list,
                      onSuffixIconPressed: () {
                        // Handle filter
                      },
                    ),
                  ),
                ),

                // Main Content
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await productController.fetchCategories();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Main Banner Slider
                          AspectRatio(
                            aspectRatio: bannerAspectRatio,
                            child: VxSwiper.builder(
                              enlargeCenterPage: true,
                              autoPlay: true,
                              viewportFraction: _isMobile(screenWidth) ? 0.9 : 0.8,
                              aspectRatio: bannerAspectRatio,
                              itemCount: brandList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: Spacing.sm,
                                    vertical: Spacing.xs,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: AppBorders.roundedMd,
                                    boxShadow: Elevation.low,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: AppBorders.roundedMd,
                                    child: Image.network(
                                      brandList[index],
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Container(
                                          color: AppColors.surface,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                  : null,
                                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: AppColors.surface,
                                          child: Center(
                                            child: Icon(
                                              Icons.error_outline,
                                              color: AppColors.error,
                                              size: 32,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          SizedBox(height: Spacing.lg),
                          
                          // Categories Section
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Categories",
                                  style: AppTypography.titleLarge,
                                ),
                                SizedBox(height: Spacing.sm),
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    final itemWidth = (constraints.maxWidth - ((categoryColumns - 1) * Spacing.sm)) / categoryColumns;
                                    final itemHeight = itemWidth * 1.2;
                                    return GridView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: categoryColumns,
                                        mainAxisSpacing: Spacing.sm,
                                        crossAxisSpacing: Spacing.sm,
                                        childAspectRatio: itemWidth / itemHeight,
                                      ),
                                      itemCount: 8,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.surface,
                                            borderRadius: AppBorders.roundedMd,
                                            boxShadow: Elevation.low,
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                productController.setCurrentCategory(categoryNames[index]);
                                                // Navigate to category screen
                                              },
                                              borderRadius: AppBorders.roundedMd,
                                              child: Padding(
                                                padding: EdgeInsets.all(_isMobile(screenWidth) ? Spacing.xs : Spacing.sm),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.network(
                                                      categoryImages[index],
                                                      height: itemWidth * 0.5,
                                                      width: itemWidth * 0.5,
                                                      fit: BoxFit.cover,
                                                      loadingBuilder: (context, child, loadingProgress) {
                                                        if (loadingProgress == null) return child;
                                                        return SizedBox(
                                                          height: itemWidth * 0.5,
                                                          width: itemWidth * 0.5,
                                                          child: Center(
                                                            child: CircularProgressIndicator(
                                                              value: loadingProgress.expectedTotalBytes != null
                                                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                                  : null,
                                                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                                              strokeWidth: 2,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Container(
                                                          height: itemWidth * 0.5,
                                                          width: itemWidth * 0.5,
                                                          color: AppColors.surface,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.error_outline,
                                                              color: AppColors.error,
                                                              size: 24,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    SizedBox(height: _isMobile(screenWidth) ? Spacing.xs : Spacing.sm),
                                                    Flexible(
                                                      child: Text(
                                                        categoryNames[index],
                                                        style: _isMobile(screenWidth) 
                                                          ? AppTypography.labelSmall 
                                                          : AppTypography.labelLarge,
                                                        textAlign: TextAlign.center,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: Spacing.lg),

                          // Featured Products Section
                          Container(
                            width: double.infinity,
                            color: AppColors.surface,
                            child: Padding(
                              padding: EdgeInsets.all(horizontalPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          featuredProducts,
                                          style: AppTypography.titleLarge,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Navigate to all products
                                        },
                                        child: Text(
                                          "View All",
                                          style: AppTypography.labelLarge.copyWith(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Spacing.md),
                                  SizedBox(
                                    height: productCardHeight,
                                    child: Obx(() {
                                      if (productController.isLoading.value) {
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 3,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                right: Spacing.md,
                                                left: index == 0 ? Spacing.xs : 0,
                                              ),
                                              child: SizedBox(
                                                width: productCardWidth,
                                                child: const ProductGridItemShimmer(),
                                              ),
                                            );
                                          },
                                        );
                                      }

                                      final products = productController.categoryProducts['Electronics'] ?? [];
                                      if (products.isEmpty) {
                                        return Center(
                                          child: Text(
                                            'No products available',
                                            style: AppTypography.bodyLarge,
                                          ),
                                        );
                                      }

                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: products.take(6).length,
                                        itemBuilder: (context, index) {
                                          final product = products[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              right: Spacing.md,
                                              left: index == 0 ? Spacing.xs : 0,
                                            ),
                                            child: SizedBox(
                                              width: productCardWidth,
                                              child: ProductCard(
                                                product: product,
                                                maxLines: productNameMaxLines,
                                                onTap: () {
                                                  productController.setCurrentProduct(
                                                    product,
                                                    title: product.title,
                                                    price: product.price,
                                                  );
                                                  Get.to(
                                                    () => ItemDetails(title: product.title),
                                                    transition: Transition.fadeIn,
                                                    duration: const Duration(milliseconds: 300),
                                                    curve: Curves.easeInOut,
                                                  );
                                                },
                                                onAddToCart: () {
                                                  // Add to cart logic
                                                  productController.addToCart(product);
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: Spacing.lg),

                          // Flash Sale Section
                          Container(
                            width: double.infinity,
                            color: AppColors.primary,
                            child: Padding(
                              padding: EdgeInsets.all(horizontalPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Flash Sale",
                                          style: AppTypography.titleLarge.copyWith(
                                            color: AppColors.onPrimary,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Ends in: ",
                                            style: AppTypography.bodyMedium.copyWith(
                                              color: AppColors.onPrimary,
                                            ),
                                          ),
                                          Text(
                                            "02:45:30",
                                            style: AppTypography.titleLarge.copyWith(
                                              color: AppColors.onPrimary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Spacing.md),
                                  SizedBox(
                                    height: productCardHeight,
                                    child: Obx(() {
                                      if (productController.isLoading.value) {
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 3,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                right: Spacing.md,
                                                left: index == 0 ? Spacing.xs : 0,
                                              ),
                                              child: SizedBox(
                                                width: productCardWidth,
                                                child: const ProductGridItemShimmer(),
                                              ),
                                            );
                                          },
                                        );
                                      }

                                      final products = productController.categoryProducts['Women Clothing'] ?? [];
                                      if (products.isEmpty) {
                                        return Center(
                                          child: Text(
                                            'No products available',
                                            style: AppTypography.bodyLarge.copyWith(
                                              color: AppColors.onPrimary,
                                            ),
                                          ),
                                        );
                                      }

                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: products.take(6).length,
                                        itemBuilder: (context, index) {
                                          final product = products[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              right: Spacing.md,
                                              left: index == 0 ? Spacing.xs : 0,
                                            ),
                                            child: SizedBox(
                                              width: productCardWidth,
                                              child: ProductCard(
                                                product: product,
                                                maxLines: productNameMaxLines,
                                                onTap: () {
                                                  productController.setCurrentProduct(
                                                    product,
                                                    title: product.title,
                                                    price: product.price,
                                                  );
                                                  Get.to(
                                                    () => ItemDetails(title: product.title),
                                                    transition: Transition.fadeIn,
                                                    duration: const Duration(milliseconds: 300),
                                                    curve: Curves.easeInOut,
                                                  );
                                                },
                                                onAddToCart: () {
                                                  // Add to cart logic
                                                  productController.addToCart(product);
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: Spacing.lg),

                          // Popular Products Grid
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Popular Products",
                                  style: AppTypography.titleLarge,
                                ),
                                SizedBox(height: Spacing.md),
                                Obx(() {
                                  if (productController.isLoading.value) {
                                    return const ProductGridShimmer();
                                  }

                                  final products = productController.categoryProducts['Men Clothing'] ?? [];
                                  if (products.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(Spacing.lg),
                                        child: Text(
                                          'No products available',
                                          style: AppTypography.bodyLarge,
                                        ),
                                      ),
                                    );
                                  }

                                  return GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: gridColumns,
                                      mainAxisSpacing: Spacing.md,
                                      crossAxisSpacing: Spacing.md,
                                      childAspectRatio: productCardWidth / productCardHeight,
                                    ),
                                    itemCount: products.take(gridColumns * 2).length,
                                    itemBuilder: (context, index) {
                                      final product = products[index];
                                      return ProductCard(
                                        product: product,
                                        maxLines: productNameMaxLines,
                                        onTap: () {
                                          productController.setCurrentProduct(
                                            product,
                                            title: product.title,
                                            price: product.price,
                                          );
                                          Get.to(
                                            () => ItemDetails(title: product.title),
                                            transition: Transition.fadeIn,
                                            duration: const Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        onAddToCart: () {
                                          // Add to cart logic
                                          productController.addToCart(product);
                                        },
                                      );
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                          // Add bottom padding for better scroll experience
                          SizedBox(height: Spacing.lg),
                        ],
                      ),
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
}
