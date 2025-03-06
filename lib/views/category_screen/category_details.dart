// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/constants/common_lists.dart';
import 'package:shopwithme/controllers/product_controller.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/inputs.dart';
import 'package:shopwithme/views/home_screen/components/product_card.dart';
import 'package:shopwithme/views/category_screen/item_details.dart';

class CategoryDetails extends StatefulWidget {
  final String title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> with SingleTickerProviderStateMixin {
  late final ProductController controller;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ProductController>();
    
    // Initialize animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Initialize category and start animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setCurrentCategory(widget.title);
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Enhanced category chip with better UI and navigation
  Widget _buildCategoryChip(String category, bool isSelected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (!isSelected) {
            // Animate out
            _animationController.reverse().then((_) {
              controller.setCurrentCategory(category);
              Get.off(
                () => CategoryDetails(title: category),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 300),
              );
            });
          }
        },
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.lg,
            vertical: Spacing.sm,
          ),
          margin: EdgeInsets.only(right: Spacing.sm),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: 1,
            ),
            boxShadow: [
              if (!isSelected)
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: AppColors.onPrimary,
                ),
                SizedBox(width: Spacing.xs),
              ],
              Text(
                category,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected ? AppColors.onPrimary : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (!isSelected) ...[
                SizedBox(width: Spacing.xs),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: AppColors.textSecondary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
        appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            _animationController.reverse().then((_) => Get.back());
          },
        ),
          actions: [
            IconButton(
              onPressed: () {},
            icon: const Icon(Icons.share, color: AppColors.textPrimary),
            ),
            IconButton(
              onPressed: () {},
            icon: const Icon(Icons.favorite_outline, color: AppColors.textPrimary),
            ),
          ],
        ),
        body: Column(
          children: [
          // Search and Filter Bar with animation
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Row(
              children: [
                Expanded(
                  child: AppInput(
                        hint: 'Search in ${widget.title}',
                    prefixIcon: Icons.search,
                  ),
                ),
                SizedBox(width: Spacing.md),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {
                    // Show filter options
                  },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Categories list with animation
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                height: 48,
                margin: EdgeInsets.symmetric(vertical: Spacing.sm),
                child: ListView.builder(
                scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
                  padding: EdgeInsets.symmetric(horizontal: Spacing.md),
                  physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final category = categoryList[index];
                    return Obx(() {
                final isSelected = controller.currentCategory.value == category;
                      return _buildCategoryChip(category, isSelected);
                    });
                  },
                        ),
                      ),
                    ),
                  ),

          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.border.withOpacity(0.1),
          ),

          // Product Grid with animation
            Expanded(
            child: Obx(() {
              final products = controller.currentCategoryProducts;
              
              if (products.isEmpty) {
                return Center(
                  child: Text(
                    'No products found',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(Spacing.md),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Spacing.md,
                  crossAxisSpacing: Spacing.md,
                  childAspectRatio: 0.75,
                ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                  final product = products[index];
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: ProductCard(
                        product: product,
                        onTap: () {
                          controller.setCurrentProduct(
                            title: product.title,
                            price: product.price,
                          );
                          Get.to(
                            () => ItemDetails(title: product.title),
                            transition: Transition.fadeIn,
                          );
                        },
                    onToggleFavorite: (productId) {
                      controller.toggleFavorite(productId as int);
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
    );
  }
}
