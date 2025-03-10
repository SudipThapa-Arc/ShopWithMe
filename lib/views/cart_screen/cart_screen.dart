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

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          'Shopping Cart',
          style: AppTypography.titleLarge,
        ),
        actions: [
          if (controller.cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: () {
                // Show clear cart confirmation
                Get.defaultDialog(
                  title: 'Clear Cart',
                  titleStyle: AppTypography.titleLarge,
                  middleText: 'Are you sure you want to clear your cart?',
                  middleTextStyle: AppTypography.bodyLarge,
                  confirm: AppButton(
                    text: 'Clear',
                    onPressed: () {
                      controller.clearCart();
                      Get.back();
                    },
                    type: ButtonType.outline,
                  ),
                  cancel: AppButton(
                    text: 'Cancel',
                    onPressed: () => Get.back(),
                    type: ButtonType.text,
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
                    ..scale(isAnimating ? 1.05 : 1.0),
                  child: Container(
                    margin: EdgeInsets.only(bottom: Spacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Product Image
                        Hero(
                          tag: 'product_${item.product.id}_image',
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            child: Image.network(
                              item.product.image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
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
                                  ),
                                ),
                                SizedBox(height: Spacing.sm),
                                
                                // Quantity controls
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.neutral,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          // Decrement button
                                          AnimatedIconButton(
                                            icon: Icons.remove,
                                            onPressed: () => controller.decrementQuantity(index),
                                            color: AppColors.textPrimary,
                                          ),
                                          
                                          // Quantity
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: Spacing.md,
                                            ),
                                            child: Text(
                                              '${item.quantity}',
                                              style: AppTypography.bodyLarge.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          
                                          // Increment button
                                          AnimatedIconButton(
                                            icon: Icons.add,
                                            onPressed: () => controller.incrementQuantity(index),
                                            color: AppColors.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    Spacer(),
                                    
                                    // Remove button
                                    AnimatedIconButton(
                                      icon: Icons.delete_outline,
                                      onPressed: () => controller.decrementQuantity(index),
                                      color: AppColors.error,
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
                padding: EdgeInsets.all(Spacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textPrimary.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: AppTypography.titleLarge,
                        ),
                        Text(
                          '\$${controller.totalAmount.toStringAsFixed(2)}',
                          style: AppTypography.headlineMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Spacing.md),
                    LoadingButton(
                      isLoading: controller.isLoading.value,
                      onPressed: () => controller.proceedToCheckout(),
                      height: 50,
                      child: Text('Proceed to Checkout'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
} 