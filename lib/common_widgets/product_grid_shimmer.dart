import 'package:flutter/material.dart';
import 'package:shopwithme/common_widgets/shimmer_loading.dart';

class ProductGridShimmer extends StatelessWidget {
  const ProductGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 4, // Show 4 shimmer items
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              const ShimmerLoading.rectangular(height: 120),
              const SizedBox(height: 8),
              // Title placeholder
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerLoading.rectangular(height: 16),
                    const SizedBox(height: 8),
                    const ShimmerLoading.rectangular(height: 14, width: 80),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        ShimmerLoading.rectangular(height: 14, width: 60),
                        ShimmerLoading.circular(width: 24, height: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 