import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/borders.dart';
import 'package:shopwithme/design_system/spacing.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerLoading.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(),
  });

  const ShimmerLoading.circular({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.grey[400]!,
          shape: shapeBorder,
        ),
      ),
    );
  }
}

// Product Grid Item Shimmer
class ProductGridItemShimmer extends StatelessWidget {
  const ProductGridItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppBorders.roundedMd,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          ShimmerLoading.rectangular(
            height: 120,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppBorders.radiusMd),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title placeholder
                ShimmerLoading.rectangular(height: 16),
                SizedBox(height: Spacing.sm),
                // Price placeholder
                ShimmerLoading.rectangular(
                  height: 14,
                  width: 80,
                ),
                SizedBox(height: Spacing.md),
                // Rating placeholder
                Row(
                  children: [
                    ShimmerLoading.rectangular(
                      height: 12,
                      width: 60,
                    ),
                    Spacer(),
                    ShimmerLoading.circular(
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Category List Item Shimmer
class CategoryListItemShimmer extends StatelessWidget {
  const CategoryListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: Spacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon placeholder
            ShimmerLoading.circular(
              width: 32,
              height: 32,
            ),
            SizedBox(height: Spacing.sm),
            // Title placeholder
            ShimmerLoading.rectangular(height: 16),
            SizedBox(height: Spacing.xs),
            // Count placeholder
            ShimmerLoading.rectangular(
              height: 12,
              width: 80,
            ),
          ],
        ),
      ),
    );
  }
}

// Cart Item Shimmer
class CartItemShimmer extends StatelessWidget {
  const CartItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Spacing.md),
      padding: EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppBorders.roundedMd,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product image placeholder
          ShimmerLoading.rectangular(
            width: 80,
            height: 80,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppBorders.radiusSm),
            ),
          ),
          SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title placeholder
                ShimmerLoading.rectangular(height: 16),
                SizedBox(height: Spacing.sm),
                // Price placeholder
                ShimmerLoading.rectangular(
                  height: 14,
                  width: 80,
                ),
                SizedBox(height: Spacing.md),
                // Quantity controls placeholder
                Row(
                  children: [
                    ShimmerLoading.rectangular(
                      height: 30,
                      width: 100,
                    ),
                    Spacer(),
                    ShimmerLoading.circular(
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 