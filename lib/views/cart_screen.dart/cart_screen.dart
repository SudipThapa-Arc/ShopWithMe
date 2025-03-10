import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/controllers/cart_controller.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/buttons.dart';
import 'package:shopwithme/common_widgets/loading_indicator.dart';
import 'package:shopwithme/common_widgets/animated_button.dart';
import 'package:shopwithme/common_widgets/error_widgets.dart';
import 'package:shopwithme/common_widgets/shimmer_loading.dart';
import 'package:shopwithme/models/product_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();
    
    // Add dummy items for demo
    if (controller.cartItems.isEmpty) {
      controller.addDummyItems();
    }
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          'Shopping Cart',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          if (controller.cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: AppColors.error,
              tooltip: 'Clear Cart',
              onPressed: () {
                Get.defaultDialog(
                  title: 'Clear Cart',
                  titleStyle: AppTypography.titleLarge,
                  middleText: 'Are you sure you want to clear your cart?',
                  middleTextStyle: AppTypography.bodyLarge,
                  backgroundColor: AppColors.surface,
                  radius: 12,
                  confirm: AppButton(
                    text: 'Clear',
                    onPressed: () {
                      controller.clearCart();
                      Get.back();
                    },
                    type: ButtonType.error,
                  ),
                  cancel: AppButton(
                    text: 'Cancel',
                    onPressed: () => Get.back(),
                    type: ButtonType.outline,
                  ),
                );
              },
            ),
        ],
      ),
      body: Obx(() {
        // Show loading state
        if (controller.isLoading.value) {
          return ListView.builder(
            padding: EdgeInsets.all(Spacing.md),
            itemCount: 3,
            itemBuilder: (context, index) => CartItemShimmer(),
          );
        }
        
        // Show empty state
        if (controller.cartItems.isEmpty) {
          return EmptyStateWidget.cart(
            onAction: () => Get.back(),
          );
        }
        
        // Show cart items
        return Stack(
          children: [
            // Cart Items List
            ListView.separated(
              padding: EdgeInsets.fromLTRB(
                Spacing.md,
                Spacing.md,
                Spacing.md,
                100, // Space for checkout button
              ),
              itemCount: controller.cartItems.length,
              separatorBuilder: (context, index) => SizedBox(height: Spacing.md),
              itemBuilder: (context, index) {
                final item = controller.cartItems[index];
                final isAnimating = controller.animatingItemId.value == item.product.id;
                
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  transform: Matrix4.identity()
                    ..scale(isAnimating ? 1.02 : 1.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: Spacing.sm,
                      vertical: Spacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow.withOpacity(0.08),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Product Image with shimmer loading
                        Hero(
                          tag: 'product_${item.product.id}_image',
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            child: Image.network(
                              item.product.image,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return ShimmerLoading.circular(
                                  width: 120,
                                  height: 120,
                                  shapeBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 120,
                                  height: 120,
                                  color: AppColors.background,
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: AppColors.textSecondary,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: Spacing.md),
                        
                        // Product Details
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Spacing.md),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.title,
                                  style: Theme.of(context).textTheme.titleMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: Spacing.xs),
                                Text(
                                  '\$${item.product.price.toStringAsFixed(2)}',
                                  style: AppTypography.titleLarge.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: Spacing.sm),
                                
                                // Quantity controls with improved UI
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.background,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          AnimatedIconButton(
                                            icon: Icons.remove_rounded,
                                            onPressed: () => controller.decrementQuantity(index),
                                            color: AppColors.textPrimary,
                                            size: 32,
                                          ),
                                          Container(
                                            width: 40,
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${item.quantity}',
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          AnimatedIconButton(
                                            icon: Icons.add_rounded,
                                            onPressed: () => controller.incrementQuantity(index),
                                            color: AppColors.primary,
                                            size: 32,
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    Spacer(),
                                    
                                    // Delete button with tooltip
                                    Tooltip(
                                      message: 'Remove item',
                                      child: AnimatedIconButton(
                                        icon: Icons.delete_outline_rounded,
                                        onPressed: () => controller.removeItem(index),
                                        color: AppColors.error,
                                        size: 28,
                                      ),
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
                );
              },
            ),

            // Checkout Section
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(Spacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow.withOpacity(0.12),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: AppTypography.titleLarge.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            '\$${controller.totalAmount.toStringAsFixed(2)}',
                            style: AppTypography.headlineMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Spacing.lg),
                      LoadingButton(
                        isLoading: controller.isLoading.value,
                        onPressed: () => controller.proceedToCheckout(),
                        height: 56,
                        borderRadius: 16,
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryDark],
                        ),
                        child: Text(
                          'Proceed to Checkout',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// Add this extension to CartController
extension CartControllerExtension on CartController {
  void addDummyItems() {
    final dummyProducts = [
      Product(
        id: '1',
        title: 'Nike Air Max 270',
        price: 149.99,
        image: 'https://raw.githubusercontent.com/flutter/assets-for-api-docs/master/assets/shoes.jpg',
        category: 'Shoes',
        colors: ['Black', 'White', 'Red'],
        description: 'Iconic Nike Air cushioning and modern design for all-day comfort',
        brand: 'Nike',
        material: 'Mesh & Synthetic',
      ),
      Product(
        id: '2',
        title: 'Apple AirPods Pro',
        price: 249.99,
        image: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQD83?wid=572&hei=572&fmt=jpeg',
        category: 'Electronics',
        colors: ['White'],
        description: 'Active noise cancellation for immersive sound',
        brand: 'Apple',
        material: 'Plastic',
      ),
      Product(
        id: '3',
        title: 'Samsung Galaxy Watch 5',
        price: 279.99,
        image: 'https://images.samsung.com/is/image/samsung/p6pim/levant/2208/gallery/levant-galaxy-watch5-40mm-431107-sm-r900nzaamea-533187365',
        category: 'Wearables',
        colors: ['Black', 'Silver'],
        description: 'Advanced health monitoring and fitness tracking',
        brand: 'Samsung',
        material: 'Aluminum',
      ),
    ];

    for (var product in dummyProducts) {
      addToCart(product);
    }
  }
} 