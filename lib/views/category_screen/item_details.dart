import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopwithme/constants/common_lists.dart';
import 'package:shopwithme/controllers/product_controller.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/common_widgets/add_to_cart_animation.dart';
import 'package:shopwithme/views/category_screen/category_details.dart';


class ItemDetails extends StatefulWidget {
  final String title;
  const ItemDetails({super.key, required this.title});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> with SingleTickerProviderStateMixin {
  late final ProductController controller;
  final GlobalKey _cartIconKey = GlobalKey();
  Offset? _cartIconPosition;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ProductController>();
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCartIconPosition();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateCartIconPosition() {
    final RenderBox? renderBox = 
        _cartIconKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _cartIconPosition = renderBox.localToGlobal(Offset.zero);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var product = controller.currentProduct.value;

    if (product == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          title: Text(
            'Product not found',
            style: AppTypography.titleLarge,
          ),
        ),
        body: Center(
          child: Text(
            'Product details not available',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // App Bar with Image
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
        backgroundColor: AppColors.surface,
        elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'product-${product.id}',
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        leading: IconButton(
                  icon: Container(
                    padding: EdgeInsets.all(Spacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.surface.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                  ),
                  onPressed: () {
                    _animationController.reverse().then((_) => Get.back());
                  },
        ),
        actions: [
                  IconButton(
                    icon: Container(
                      padding: EdgeInsets.all(Spacing.xs),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.favorite_border, color: AppColors.textPrimary),
                    ),
                    onPressed: () {
                      // Toggle favorite
                    },
                  ),
          IconButton(
            key: _cartIconKey,
                    icon: Container(
                      padding: EdgeInsets.all(Spacing.xs),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.shopping_cart, color: AppColors.textPrimary),
                    ),
            onPressed: () {
                      Get.toNamed('/cart');
            },
          ),
        ],
      ),

              // Product Details
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      padding: EdgeInsets.all(Spacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                        product.title,
                        style: AppTypography.headlineMedium,
                      ),
                              ),
                      Text(
                        '\$${product.price}',
                        style: AppTypography.titleLarge.copyWith(
                          color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                        ),
                      ),
                            ],
                          ),
                      SizedBox(height: Spacing.lg),
                      _buildCategoryNavigation(),
                      SizedBox(height: Spacing.lg),

                          // Rating and Reviews
                          Row(
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < (product.rating ?? 0).floor()
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: AppColors.warning,
                                    size: 20,
                                  );
                                }),
                              ),
                              SizedBox(width: Spacing.sm),
                      Text(
                                '${product.rating}',
                                style: Theme.of(context).textTheme.titleMedium,
                      ),
                              SizedBox(width: Spacing.xs),
                      Text(
                                '(${product.reviews} reviews)',
                                style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                            ],
                          ),
                          SizedBox(height: Spacing.lg),

                          // Brand and Delivery Info
                          Container(
                            padding: EdgeInsets.all(Spacing.md),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Icon(Icons.inventory_2, color: AppColors.primary),
                                      SizedBox(height: Spacing.xs),
                                      Text(
                                        product.inStock ? 'In Stock' : 'Out of Stock',
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Icon(Icons.local_shipping, color: AppColors.primary),
                                      SizedBox(height: Spacing.xs),
                                      Text(
                                        product.deliveryTime,
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Icon(Icons.verified, color: AppColors.primary),
                                      SizedBox(height: Spacing.xs),
                                      Text(
                                        product.brand,
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      SizedBox(height: Spacing.lg),

                          // Colors Section
                      if (product.colors.isNotEmpty) ...[
                        Text(
                              'Available Colors',
                          style: AppTypography.titleLarge,
                        ),
                        SizedBox(height: Spacing.sm),
                        Wrap(
                              spacing: Spacing.sm,
                              children: List.generate(
                                product.colors.length,
                                (index) => Obx(() {
                                  final isSelected = controller.colorIndex.value == index;
                                  return GestureDetector(
                                    onTap: () => controller.setColorIndex(index),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      padding: EdgeInsets.all(isSelected ? 3 : 2),
                                  decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected 
                                              ? AppColors.primary 
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: getColorFromString(
                                          product.colors[index],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(height: Spacing.lg),
                          ],

                          // Size Guide (if applicable)
                          if (product.sizes?.isNotEmpty ?? false) ...[
                            Text(
                              'Select Size',
                              style: AppTypography.titleLarge,
                            ),
                            SizedBox(height: Spacing.sm),
                            SizedBox(
                              height: 50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: product.sizes!.length,
                                itemBuilder: (context, index) {
                                  return Obx(() {
                                    final isSelected = controller.sizeIndex.value == index;
                                    return GestureDetector(
                                      onTap: () => controller.setSizeIndex(index),
                                      child: Container(
                                        margin: EdgeInsets.only(right: Spacing.sm),
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: isSelected ? AppColors.primary : AppColors.surface,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: isSelected ? AppColors.primary : AppColors.border,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            product.sizes![index],
                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              color: isSelected ? AppColors.onPrimary : AppColors.textPrimary,
                                            ),
                                          ),
                                ),
                              ),
                            );
                                  });
                                },
                              ),
                        ),
                        SizedBox(height: Spacing.lg),
                      ],

                          // Features
                          if (product.features.isNotEmpty) ...[
                            Text(
                              'Features',
                              style: AppTypography.titleLarge,
                            ),
                            SizedBox(height: Spacing.sm),
                            ...product.features.map((feature) => Padding(
                              padding: EdgeInsets.only(bottom: Spacing.xs),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle, color: AppColors.success, size: 20),
                                  SizedBox(width: Spacing.sm),
                                  Text(
                                    feature,
                                    style: AppTypography.bodyMedium,
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(height: Spacing.lg),
                          ],

                          // Care Instructions
                          if (product.careInstructions.isNotEmpty) ...[
                            Text(
                              'Care Instructions',
                              style: AppTypography.titleLarge,
                            ),
                            SizedBox(height: Spacing.sm),
                            Container(
                              padding: EdgeInsets.all(Spacing.md),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: product.careInstructions.map((instruction) => Padding(
                                  padding: EdgeInsets.only(bottom: Spacing.xs),
                                  child: Text(
                                    '• $instruction',
                                    style: AppTypography.bodyMedium,
                                  ),
                                )).toList(),
                              ),
                            ),
                          ],

                          // Description
                          Text(
                            'Description',
                            style: AppTypography.titleLarge,
                          ),
                          SizedBox(height: Spacing.sm),
                          Text(
                            product.description,
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: Spacing.xl),
                    ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Bottom Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
              color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Quantity Controls
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: controller.decreaseQuantity,
                        ),
                        Obx(() => Text(
                          '${controller.quantity.value}',
                          style: AppTypography.titleLarge,
                        )),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: controller.increaseQuantity,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: Spacing.md),
                  // Add to Cart Button
                  Expanded(
                    child: ElevatedButton(
                onPressed: () {
                  controller.addToCart(product);
                        // Show animation
                        if (_cartIconPosition != null) {
                          showAddToCartAnimation();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: Spacing.md),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add to Cart Animation
          if (_cartIconPosition != null)
            AddToCartAnimation(
              startPosition: _getButtonPosition(),
              endPosition: _cartIconPosition!,
              onPressed: () {
                // Show success snackbar
                Get.snackbar(
                  'Success',
                  'Item added to cart successfully!',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: AppColors.success,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                );

                // Vibrate device
                HapticFeedback.mediumImpact();

                // Update cart badge
                controller.updateCartTotal();
              },
              child: Container(
                padding: EdgeInsets.all(Spacing.sm),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: AppColors.onPrimary,
                  size: 20,
                      ),
                    ),
          ),
        ],
      ),
    );
  }
  
  Offset _getButtonPosition() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      return renderBox.localToGlobal(
        Offset(renderBox.size.width - 60, renderBox.size.height - 100),
      );
    }
    return const Offset(0, 0);
  }

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

  void showAddToCartAnimation() {
    if (_cartIconPosition != null) {
      // Show success snackbar
      Get.snackbar(
        'Success',
        'Item added to cart successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.success,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Vibrate device
      HapticFeedback.mediumImpact();

      // Update cart badge
      controller.updateCartTotal();
    }
  }

  Widget _buildCategoryNavigation() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: Spacing.md),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categoryList.map((category) {
          final isSelected = controller.currentCategory.value == category;
          return Padding(
            padding: EdgeInsets.only(right: Spacing.sm),
            child: InkWell(
              onTap: () {
                if (!isSelected) {
                  controller.setCurrentCategory(category);
                  // First animate out current screen
                  _animationController.reverse().then((_) {
                    Get.off(
                      () => CategoryDetails(title: category),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 300),
                    );
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.sm,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
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
                child: Text(
                  category,
                  style: AppTypography.bodyMedium.copyWith(
                    color: isSelected ? AppColors.onPrimary : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
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

