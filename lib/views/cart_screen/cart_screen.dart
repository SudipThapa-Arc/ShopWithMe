import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/controllers/cart_controller.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/buttons.dart';
import 'package:shopwithme/design_system/cards.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

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
      body: Obx(
        () {
          if (controller.cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: Spacing.md),
                  Text(
                    'Your cart is empty',
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: Spacing.xs),
                  Text(
                    'Add items to start shopping',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: Spacing.lg),
                  AppButton(
                    text: 'Start Shopping',
                    onPressed: () {
                      // Navigate to home or categories
                      Get.back();
                    },
                    type: ButtonType.primary,
                  ),
                ],
              ),
            );
          }

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
                  return AppCard.elevated(
                    child: Row(
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.product.image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: Spacing.md),
                        
                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.title,
                                style: AppTypography.labelLarge,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: Spacing.xs),
                              Text(
                                '\$${item.product.price}',
                                style: AppTypography.titleLarge.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Quantity Controls
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => controller.incrementQuantity(index),
                            ),
                            Text(
                              '${item.quantity}',
                              style: AppTypography.bodyLarge,
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => controller.decrementQuantity(index),
                            ),
                          ],
                        ),
                      ],
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
                      AppButton(
                        text: 'Proceed to Checkout',
                        onPressed: () {
                          // Navigate to checkout
                          controller.proceedToCheckout();
                        },
                        type: ButtonType.primary,
                        size: ButtonSize.large,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
} 