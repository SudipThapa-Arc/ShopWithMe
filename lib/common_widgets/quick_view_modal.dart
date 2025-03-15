import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/elevation.dart';
import 'package:shopwithme/design_system/borders.dart';
import 'package:shopwithme/models/product_model.dart';
import 'package:shopwithme/controllers/product_controller.dart';
import 'package:shopwithme/common_widgets/custom_button.dart';

class QuickViewModal extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;
  final VoidCallback? onViewDetails;

  const QuickViewModal({
    super.key,
    required this.product,
    this.onAddToCart,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: Elevation.high,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: Spacing.sm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.neutral,
                borderRadius: AppBorders.roundedFull,
              ),
            ),
          ),
          
          // Scrollable content
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Product Image
                  Hero(
                    tag: 'product_${product.id}_quickview',
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(product.image),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(Spacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          product.title,
                          style: AppTypography.titleLarge,
                        ),
                        SizedBox(height: Spacing.sm),

                        // Price
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: AppTypography.headlineMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Spacing.md),

                        // Description
                        Text(
                          product.description,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: Spacing.md),

                        // Color Options
                        Text(
                          'Colors',
                          style: AppTypography.labelLarge,
                        ),
                        SizedBox(height: Spacing.xs),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: Get.find<ProductController>()
                                .colors
                                .map((color) => _buildColorOption(
                                    color, Get.find<ProductController>()))
                                .toList(),
                          ),
                        ),
                        SizedBox(height: Spacing.md),

                        // Size Options
                        Text(
                          'Sizes',
                          style: AppTypography.labelLarge,
                        ),
                        SizedBox(height: Spacing.xs),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: Get.find<ProductController>()
                                .sizes
                                .map((size) => _buildSizeOption(
                                    size, Get.find<ProductController>()))
                                .toList(),
                          ),
                        ),
                        SizedBox(height: Spacing.lg),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: 'Add to Cart',
                                onPressed: () {
                                  onAddToCart?.call();
                                  Get.back();
                                },
                              ),
                            ),
                            SizedBox(width: Spacing.md),
                            Expanded(
                              child: CustomButton(
                                text: 'View Details',
                                onPressed: () {
                                  onViewDetails?.call();
                                  Get.back();
                                },
                                isOutlined: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption(String color, ProductController controller) {
    return Obx(() => GestureDetector(
      onTap: () => controller.setColorIndex(
        controller.colors.indexOf(color)
      ),
      child: Container(
        width: 32,
        height: 32,
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: _getColorFromString(color),
          shape: BoxShape.circle,
          border: Border.all(
            color: controller.colorIndex.value == controller.colors.indexOf(color)
                ? AppColors.primary
                : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    ));
  }

  Widget _buildSizeOption(String size, ProductController controller) {
    return Obx(() => GestureDetector(
      onTap: () => controller.setSizeIndex(
        controller.sizes.indexOf(size)
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        decoration: BoxDecoration(
          color: controller.sizeIndex.value == controller.sizes.indexOf(size)
              ? AppColors.primary
              : AppColors.surface,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: controller.sizeIndex.value == controller.sizes.indexOf(size)
                ? AppColors.primary
                : AppColors.neutral,
          ),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: controller.sizeIndex.value == controller.sizes.indexOf(size)
                ? AppColors.onPrimary
                : AppColors.textPrimary,
          ),
        ),
      ),
    ));
  }

  Color _getColorFromString(String colorName) {
    // Implementation from your existing code
    switch (colorName.toLowerCase()) {
      case 'red': return Colors.red;
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      // Add more colors as needed
      default: return Colors.grey;
    }
  }
} 