import 'package:flutter/material.dart';
import 'package:shopwithme/common_widgets/animated_favorite_button.dart';
import 'package:shopwithme/design_system/borders.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/models/product_model.dart';

import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(dynamic) onToggleFavorite;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onToggleFavorite,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppBorders.radiusMd),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppBorders.radiusMd),
              ),
              child: Image.network(
                product.image,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(Spacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: AppTypography.labelLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Spacing.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price}',
                        style: AppTypography.titleLarge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      AnimatedFavoriteButton(
                        isFavorite: product.isFavorite,
                        onChanged: (value) => onToggleFavorite(product.id),
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 