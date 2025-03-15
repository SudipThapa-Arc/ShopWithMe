import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/elevation.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/borders.dart';
import 'package:shopwithme/models/product_model.dart';
import 'package:shopwithme/controllers/product_controller.dart';
import 'package:shopwithme/common_widgets/quick_view_modal.dart';
import 'package:shopwithme/design_system/typography.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final int maxLines;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.maxLines = 2,
    this.onAddToCart,
  });

  void _showQuickView(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuickViewModal(
        product: product,
        onAddToCart: onAddToCart,
        onViewDetails: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppBorders.roundedMd,
        boxShadow: Elevation.low,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: () => _showQuickView(context),
          onDoubleTap: () => _showQuickView(context),
          borderRadius: AppBorders.roundedMd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with Quick View
              Stack(
                children: [
                  Hero(
                    tag: 'product_${product.id}',
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(AppBorders.radiusMd),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(product.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  if (onTap != null)
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onTap,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(AppBorders.radiusMd),
                              ),
                              color: AppColors.secondary.withOpacity(0.3),
                            ),
                            child: Center(
                              child: Text(
                                'Quick View',
                                style: AppTypography.labelLarge.copyWith(
                                  color: AppColors.onSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Wishlist Toggle
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Obx(() => IconButton(
                      icon: Icon(
                        controller.isFavorite(int.parse(product.id))
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: controller.isFavorite(int.parse(product.id))
                            ? AppColors.error
                            : AppColors.onSecondary,
                      ),
                      onPressed: () => controller.toggleFavorite(int.parse(product.id)),
                    )),
                  ),
                ],
              ),
              
              // Product Details
              Padding(
                padding: EdgeInsets.all(Spacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Spacing.xs),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: AppTypography.titleLarge.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 