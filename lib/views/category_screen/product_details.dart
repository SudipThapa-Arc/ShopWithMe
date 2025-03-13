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
import 'package:shopwithme/common_widgets/animated_button.dart';
import 'package:shopwithme/common_widgets/error_widgets.dart' as app_errors;
import 'package:shopwithme/common_widgets/shimmer_loading.dart';

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
      body: Obx(() {
        // Show loading state
        if (controller.isLoading.value) {
          return _buildLoadingState();
        }
        
        // Show error state
        if (controller.hasError.value) {
          return app_errors.ErrorWidget.network(
            onRetry: () {
              if (controller.currentProduct.value != null) {
                controller.fetchProductsByCategory(
                  controller.currentProduct.value!.category
                );
              }
            },
          );
        }
        
        // Show product details
        if (controller.currentProduct.value == null) {
          return app_errors.ErrorWidget.empty(
            title: 'Product Not Found',
            message: 'The product you are looking for is not available.',
            onRetry: () => Get.back(),
            retryText: 'Go Back',
          );
        }
        
        final product = controller.currentProduct.value!;
        
        return Stack(
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
                    Obx(() => IconButton(
                      onPressed: () {
                        final index = int.tryParse(product.id) ?? 0;
                        controller.toggleFavorite(index);
                                            },
                      icon: Icon(
                        controller.isFavorite(int.tryParse(product.id) ?? 0)
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: controller.isFavorite(int.tryParse(product.id) ?? 0)
                            ? AppColors.error
                            : AppColors.textPrimary,
                      ),
                    )),
                    IconButton(
                      icon: Container(
                        padding: EdgeInsets.all(Spacing.xs),
                        decoration: BoxDecoration(
                          color: AppColors.surface.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.share, color: AppColors.textPrimary),
                      ),
                      onPressed: () {
                        // Share product
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
                                  '\$${product.price.toStringAsFixed(2)}',
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
                                          backgroundColor: _getColorFromString(
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
                      child: AnimatedButton(
                        onPressed: () {
                          // Add to cart
                          controller.addToCart(product);
                          
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
                        color: AppColors.primary,
                        textColor: AppColors.onPrimary,
                        borderRadius: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: AppColors.onPrimary,
                            ),
                            SizedBox(width: Spacing.xs),
                            Text(
                              'Add to Cart',
                              style: AppTypography.labelLarge.copyWith(
                                color: AppColors.onPrimary,
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
        );
      }),
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

  Color _getColorFromString(String colorName) {
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

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          ShimmerLoading.rectangular(
            height: 300,
          ),
          
          Padding(
            padding: EdgeInsets.all(Spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title placeholder
                ShimmerLoading.rectangular(
                  height: 24,
                  width: 200,
                ),
                SizedBox(height: Spacing.sm),
                
                // Price and rating placeholder
                Row(
                  children: [
                    ShimmerLoading.rectangular(
                      height: 20,
                      width: 80,
                    ),
                    Spacer(),
                    ShimmerLoading.rectangular(
                      height: 16,
                      width: 60,
                    ),
                  ],
                ),
                
                SizedBox(height: Spacing.md),
                Divider(),
                SizedBox(height: Spacing.md),
                
                // Color selection placeholder
                ShimmerLoading.rectangular(
                  height: 20,
                  width: 60,
                ),
                SizedBox(height: Spacing.sm),
                Row(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: Spacing.sm),
                      child: ShimmerLoading.circular(
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: Spacing.md),
                
                // Size selection placeholder
                ShimmerLoading.rectangular(
                  height: 20,
                  width: 60,
                ),
                SizedBox(height: Spacing.sm),
                Row(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: Spacing.sm),
                      child: ShimmerLoading.rectangular(
                        height: 40,
                        width: 40,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: Spacing.md),
                
                // Quantity placeholder
                ShimmerLoading.rectangular(
                  height: 20,
                  width: 80,
                ),
                SizedBox(height: Spacing.sm),
                ShimmerLoading.rectangular(
                  height: 40,
                  width: 120,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                
                SizedBox(height: Spacing.md),
                Divider(),
                SizedBox(height: Spacing.md),
                
                // Description placeholder
                ShimmerLoading.rectangular(
                  height: 20,
                  width: 100,
                ),
                SizedBox(height: Spacing.sm),
                ShimmerLoading.rectangular(height: 16),
                SizedBox(height: Spacing.xs),
                ShimmerLoading.rectangular(height: 16),
                SizedBox(height: Spacing.xs),
                ShimmerLoading.rectangular(height: 16),
                SizedBox(height: Spacing.xs),
                ShimmerLoading.rectangular(height: 16, width: 200),
                
                SizedBox(height: Spacing.md),
                
                // Features placeholder
                ShimmerLoading.rectangular(
                  height: 20,
                  width: 80,
                ),
                SizedBox(height: Spacing.sm),
                Row(
                  children: [
                    ShimmerLoading.circular(width: 16, height: 16),
                    SizedBox(width: Spacing.xs),
                    ShimmerLoading.rectangular(height: 16, width: 200),
                  ],
                ),
                SizedBox(height: Spacing.xs),
                Row(
                  children: [
                    ShimmerLoading.circular(width: 16, height: 16),
                    SizedBox(width: Spacing.xs),
                    ShimmerLoading.rectangular(height: 16, width: 180),
                  ],
                ),
                
                // Related products placeholder
                SizedBox(height: Spacing.lg),
                ShimmerLoading.rectangular(
                  height: 24,
                  width: 160,
                ),
                SizedBox(height: Spacing.md),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: Spacing.md),
                      child: SizedBox(
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerLoading.rectangular(
                              height: 120,
                              shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(Spacing.sm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShimmerLoading.rectangular(height: 16),
                                  SizedBox(height: Spacing.xs),
                                  ShimmerLoading.rectangular(height: 16, width: 80),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Bottom padding for add to cart button
                SizedBox(height: 100),
              ],
            ),
          ),
        ],
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

