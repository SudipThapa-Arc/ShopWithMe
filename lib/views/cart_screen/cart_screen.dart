import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/common_widgets/animated_button.dart';
import 'package:shopwithme/common_widgets/loading_indicator.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/controllers/cart_controller.dart';
import 'package:shopwithme/controllers/home_controller.dart';

import '../../common_widgets/error_widgets.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();
    final HomeController homeController = Get.find<HomeController>();
    
    // Always add dummy items for demo
    controller.addDummyItems();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: AnimatedIconButton(
          icon: Icons.arrow_back,
          color: AppColors.textPrimary,
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Cart',
          style: AppTypography.titleLarge,
        ),
        centerTitle: true,
        actions: [
          AnimatedIconButton(
            icon: Icons.delete_outline,
            color: AppColors.textPrimary,
            onPressed: () => controller.clearCart(),
          ),
        ],
      ),
      body: Obx(() {
        // Show loading state
        if (controller.isLoading.value) {
          return const Center(
            child: LoadingIndicator(
              size: 48,
              color: AppColors.primary,
            ),
          );
        }
        
        // Show empty state
        if (controller.cartItems.isEmpty) {
          return EmptyStateWidget.cart(
            onAction: () {
              homeController.currentIndex.value = 0; // Switch to home tab
            },
          );
        }
        
        // Show cart items
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(Spacing.md),
                itemCount: controller.cartItems.length,
                separatorBuilder: (context, index) => Divider(
                  height: Spacing.md,
                  color: AppColors.border,
                ),
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: Spacing.sm),
                    child: Row(
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(Spacing.xs),
                          child: Image.network(
                            item.product.image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 60,
                                color: AppColors.background,
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.textSecondary,
                                ),
                              );
                            },
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
                              ),
                              SizedBox(height: Spacing.xs),
                              Text(
                                '\$${item.product.price.toStringAsFixed(2)}',
                                style: AppTypography.titleLarge.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Quantity Controls
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(Spacing.xl),
                          ),
                          child: Row(
                            children: [
                              AnimatedIconButton(
                                icon: Icons.remove,
                                color: AppColors.textPrimary,
                                size: 20,
                                onPressed: () => controller.decrementQuantity(index),
                              ),
                              Container(
                                width: 28,
                                alignment: Alignment.center,
                                child: Text(
                                  '${item.quantity}',
                                  style: AppTypography.labelLarge,
                                ),
                              ),
                              AnimatedIconButton(
                                icon: Icons.add,
                                color: AppColors.primary,
                                size: 20,
                                onPressed: () => controller.incrementQuantity(index),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Checkout Section
            Container(
              padding: EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Subtotal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal:',
                          style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '\$${controller.totalAmount.toStringAsFixed(2)}',
                          style: AppTypography.headlineMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Spacing.md),
                    
                    // Checkout Button
                    LoadingButton(
                      isLoading: controller.isLoading.value,
                      onPressed: () => controller.proceedToCheckout(),
                      height: Spacing.buttonHeight,
                      borderRadius: Spacing.sm,
                      color: AppColors.primary,
                      child: Text(
                        'Check Out',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.onPrimary,
                        ),
                      ),
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