import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/models/product_model.dart';
import 'package:shopwithme/controllers/product_controller.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final bool showQuickView;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.showQuickView = true,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with Quick View
              Stack(
                children: [
                  Hero(
                    tag: 'product_${product.id}_image',
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(product.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  if (showQuickView)
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // Show quick view modal
                            _showQuickView(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              color: Colors.black.withOpacity(0.3),
                            ),
                            child: Center(
                              child: Text(
                                'Quick View',
                                style: TextStyle(
                                  color: Colors.white,
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
                            : Colors.white,
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
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Spacing.xs),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
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

  void _showQuickView(BuildContext context) {
    // Implement quick view modal
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        // Quick view implementation
      ),
    );
  }
} 