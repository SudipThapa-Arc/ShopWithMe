import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/models/product_model.dart';
import 'package:shopwithme/controllers/product_controller.dart';
import 'package:shopwithme/common_widgets/animated_button.dart';

class QuickViewModal extends StatelessWidget {
  final Product product;

  const QuickViewModal({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: Spacing.sm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.neutral,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Product Image
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Image.network(
                  product.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Close button
                Positioned(
                  top: Spacing.sm,
                  right: Spacing.sm,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      foregroundColor: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product Details
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Spacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: Spacing.sm),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Spacing.md),
                  
                  // Color options
                  if (product.colors.isNotEmpty) ...[
                    Text(
                      'Colors',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: Spacing.sm),
                    Wrap(
                      spacing: Spacing.sm,
                      children: product.colors.map((color) => 
                        _buildColorOption(color, controller)
                      ).toList(),
                    ),
                    SizedBox(height: Spacing.md),
                  ],

                  // Size options
                  if (product.sizes!.isNotEmpty) ...[
                    Text(
                      'Sizes',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: Spacing.sm),
                    Wrap(
                      spacing: Spacing.sm,
                      children: product.sizes!.map((size) => 
                        _buildSizeOption(size, controller)
                      ).toList(),
                    ),
                    SizedBox(height: Spacing.md),
                  ],

                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: Spacing.sm),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add to Cart Button
          Padding(
            padding: EdgeInsets.all(Spacing.md),
            child: AnimatedButton(
              onPressed: () {
                controller.addToCart(product);
                Navigator.pop(context);
                Get.snackbar(
                  'Added to Cart',
                  '${product.title} has been added to your cart',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.success,
                  colorText: AppColors.onSuccess,
                );
              },
              color: AppColors.primary,
              child: Text('Add to Cart'),
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